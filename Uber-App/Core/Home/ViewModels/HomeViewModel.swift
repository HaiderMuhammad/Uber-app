//
//  HomeViewModel.swift
//  Uber-App
//
//  Created by Haider Muhammed on 6/3/25.
//

import SwiftUI
import Firebase
import FirebaseAuth
import Combine
import MapKit


class HomeViewModel: NSObject, ObservableObject {
    
    
    // MARK: - Properties
    @Published var drivers =  [User]()
    @Published var trip : Trip?
    private let service = UserService.shared
    private var cancellables = Set<AnyCancellable>()
    private var currentUser: User?
    
    // Location Search properties
    @Published var results = [MKLocalSearchCompletion]()
    @Published var selectedUberLocation: UberLocation?
    @Published var pickupTime: String?
    @Published var dropOffTime: String?
    
    private let searchCompleter = MKLocalSearchCompleter()
    var userLocation: CLLocationCoordinate2D?
    var queryFragment: String = "" {
        didSet {
            searchCompleter.queryFragment = queryFragment
        }
    }
    
    
    // MARK: - Lifecycle
    
    override init () {
        super.init()
        fetchUser()
        searchCompleter.delegate = self
        searchCompleter.queryFragment = queryFragment
    }
    
    
    // MARK: - User API
    func fetchUser() {
        service.$user
            .sink { user in
                self.currentUser = user
                guard let user = user else { return }
                
                if user.accountType == .passenger {
                    self.fetchDrivers()
                    self.addTripObserverForPassenger()
                } else {
                    self.fetchTrips()
                }
            }
            .store(in: &cancellables)
    }
}

// MARK: - Passenger API
extension HomeViewModel {
    
    
    func addTripObserverForPassenger() {
        guard let currentUser = currentUser, currentUser.accountType == .passenger else { return }
        
        Firestore.firestore().collection("trips").whereField("passengerUid", isEqualTo: currentUser.uid).addSnapshotListener { snapshot, _ in
            guard let change = snapshot?.documentChanges.first,
                  change.type == .added
                    || change.type == .modified else { return }
            
            guard let trip = try? change.document.data(as: Trip.self) else { return }
            print("DEBUG: updated trip: \(trip.state)")
            
        }
    }
    
    func fetchDrivers() {
        Firestore.firestore().collection("users")
            .whereField("accountType", isEqualTo: AccountType.driver.rawValue)
            .getDocuments {  snapshot, _ in
                guard let documents = snapshot?.documents else { return }
                
                do {
                    let drivers = try documents.map { try $0.data(as: User.self) }
                    self.drivers = drivers
                    
                } catch {
                    print("Failed to decode users: \(error)")
                }
            }
    }
    
    func requestTrip() {
        guard let driver = drivers.first else { return }
        guard let currentUser       = currentUser else { return }
        guard let dropOffLocation   = selectedUberLocation else { return }
        let dropoffGeoPoint = GeoPoint(latitude: dropOffLocation.coordinate.latitude,
                                       longitude: dropOffLocation.coordinate.longitude)
        
        let userLocation = CLLocation(latitude: currentUser.coordinates.latitude, longitude: currentUser.coordinates.longitude)
        
        getPlaceMark(forLcoation: userLocation) { placemark, error in
            guard let placemark = placemark else { return }
            let tripCost = self.computeRidePrice(forType: .uberX)
            
            let trip = Trip(
                  passengerUid: currentUser.uid,
                driverUid: driver.uid,
                passengerName: currentUser.fullName,
                driverName: driver.fullName,
                passengerLocation: currentUser.coordinates,
                driverLocation: driver.coordinates,
                pickupLocationName: placemark.name ?? "Apple Campus",
                dropoffLocationName: dropOffLocation.title,
                pickupLocationAddress: self.addressFromPlacemark(placemark),
                pickupLocation: currentUser.coordinates,
                dropoffLocation: dropoffGeoPoint,
                tripCost: tripCost,
                distanceToPassenger: 0,
                travelTimeToPasseneger: 0,
                state: .requested
                
            )
            
            guard let encodedTrip = try? Firestore.Encoder().encode(trip) else { return }
            Firestore.firestore().collection("trips").document().setData(encodedTrip) { _ in
                print("DEBUG: Trip Uploaded Firestore")
            }
        }
    }
}

// MARK: - Driver API
extension HomeViewModel {
    func fetchTrips() {
        guard let currentUser = currentUser else { return }
        Firestore.firestore().collection("trips").whereField("driverUid", isEqualTo: currentUser.uid)
            .getDocuments() { snapshot, _ in
                guard let documents = snapshot?.documents, let document = documents.first  else { return }
                guard let trip = try? document.data(as: Trip.self ) else { return }
                
                self.trip = trip
                
                self.getDestinationRoute(from: trip.driverLocation.toCoordinate(), to: trip.pickupLocation.toCoordinate()) { route in
                    self.trip?.distanceToPassenger = route.distance
                    self.trip?.travelTimeToPasseneger = Int(route.expectedTravelTime / 60)
                }
            }
    }
    
    func rejectTrip() {
        updateTrip(state: .rejected)
    }
    
    func acceptTrip() {
        updateTrip(state: .accepted)
    }
    
    func updateTrip(state: TripState) {
        
        guard let trip = trip else { return }
        Firestore.firestore().collection("trips").document(trip.id).updateData(
            ["state": state.rawValue]) { _ in
                print("DEBUG: Did update trip with state: \(state)")
            }
    }
}


// MARK: - Location Search Helper
extension HomeViewModel {
    
    
    func addressFromPlacemark(_ placemark: CLPlacemark) -> String {
        var result: String = ""
        
        if let thoroughfare = placemark.thoroughfare {
            result += thoroughfare
        }
        
        if let subThoroughfare = placemark.subThoroughfare {
            result += " \(subThoroughfare)"
        }
        
        if let subadministrativeArea = placemark.subAdministrativeArea {
            result += ", \(subadministrativeArea)"
        }
        
        
        return result
    }
    
    func getPlaceMark(forLcoation location: CLLocation, completion: @escaping (CLPlacemark?, Error?) -> Void ) {
        CLGeocoder().reverseGeocodeLocation(location) { placemarks, error in
            if let error = error {
                completion(nil, error)
                return
            }
            
            guard let placeMark = placemarks?.first else { return }
            completion(placeMark, nil)
            
        }
    }
    
    func selectLocation(_ localSearch: MKLocalSearchCompletion, config: LocationResultsViewConfig) {
        
        
        locationSearch(forLocalSearchCompletion: localSearch) { response, error in
            if let error = error {
                print(error.localizedDescription)
                return
            }
            guard let item = response?.mapItems.first else { return }
            let cooredinate = item.placemark.coordinate
            
            switch config {
            case .ride:
                self.selectedUberLocation = UberLocation(title: localSearch.title, coordinate: cooredinate)
                
            case .saveLocation(let viewModel):
                guard let uid = Auth.auth().currentUser?.uid else { return }
                let savedLocation = SavedLocation(
                    title: localSearch.title,
                    address: localSearch.subtitle,
                    coordinates: GeoPoint(latitude: cooredinate.latitude,
                                          longitude: cooredinate.longitude))
                
                guard let encodedLocation = try? Firestore.Encoder().encode(savedLocation) else { return }
                Firestore.firestore().collection("users").document(uid).updateData([
                    viewModel.dataaseKey: encodedLocation
                ])
            }
        }
    }
    
    func locationSearch(forLocalSearchCompletion localSearch: MKLocalSearchCompletion, completion: @escaping MKLocalSearch.CompletionHandler) {
        let searchRequest = MKLocalSearch.Request()
        searchRequest.naturalLanguageQuery = localSearch.title.appending(localSearch.subtitle)
        let search = MKLocalSearch(request: searchRequest)
        search.start(completionHandler: completion)
        
    }
    
    func computeRidePrice(forType type: RideType) -> Double  {
        guard let destCoordinate = selectedUberLocation?.coordinate else { return 0.0 }
        guard let userCoordinate = self.userLocation else { return 0.0 }
        
        let userLocation = CLLocation(latitude: userCoordinate.latitude, longitude: userCoordinate.longitude)
        let destination = CLLocation(latitude: destCoordinate.latitude, longitude: destCoordinate.longitude )
        
        let tripDistanceInMeters = userLocation.distance(from: destination)
        return type.computePrice(for: tripDistanceInMeters)
    }
    
    
    func getDestinationRoute(from userLocation: CLLocationCoordinate2D,
                             to destination: CLLocationCoordinate2D,
                             completion: @escaping(MKRoute) -> Void) {
        
        let userPlacemark = MKPlacemark(coordinate: userLocation)
        let destPlacemark = MKPlacemark(coordinate: destination)
        let request = MKDirections.Request()
        request.source = MKMapItem(placemark: userPlacemark)
        request.destination = MKMapItem(placemark: destPlacemark)
        let directions = MKDirections(request: request)
        
        directions.calculate { response, error in
            if let error = error {
                print("Failed to get directions \(error)")
                return
            }
            
            guard let route = response?.routes.first else { return }
            self.configurePickupAndDropOff(with: route.expectedTravelTime)
            
            completion(route)
            
        }
        
    }
    
    func configurePickupAndDropOff(with expectedTravelTime: Double) {
        
        let formatter = DateFormatter()
        formatter.dateFormat = "h:mm a"
        
        pickupTime  = formatter.string(from: Date())
        dropOffTime = formatter.string(from: Date() + expectedTravelTime)
        
    }
}



extension HomeViewModel: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        self.results = completer.results
    }
}
