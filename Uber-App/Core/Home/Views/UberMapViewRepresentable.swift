//
//  UberMapViewRepresentable.swift
//  Uber-App
//
//  Created by Haider Muhammed on 5/31/25.
//

import SwiftUI
import MapKit

struct UberMapViewRepresentable: UIViewRepresentable {
    let mapView = MKMapView()
    let locationManager = LocationManager.shared
    @Binding var mapState: MapViewState
//    @EnvironmentObject var locationViewModel: LocationSearchViewModel
    @EnvironmentObject var homeViewModel: HomeViewModel
    
    
    func makeUIView(context: Context) -> some UIView {
        mapView.delegate = context.coordinator
        mapView.isRotateEnabled = false
        mapView.showsUserLocation = true
//        mapView.userTrackingMode = .follow
        
        return mapView
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        
        switch mapState {
        case .noInput:
            context.coordinator.clearMapViewAndRecenterOnUserLocation()
            context.coordinator.addDriversToMap(homeViewModel.drivers)
            break
        case .searchingForLocation:
            break
        case .locationSelected:
            if let coordinate = homeViewModel.selectedUberLocation?.coordinate {
                context.coordinator.addAndSelectAnnotation(withCoordinate: coordinate)
                context.coordinator.configurePolyline(withDestinationCoordinate: coordinate)
            }
            break
        
        case .polylineAdded:
            break
            
        case .tripAccepted:
            guard let trip   = homeViewModel.trip else { return }
            guard let driver = homeViewModel.currentUser, driver.accountType == .driver else { return }
            guard let route  = homeViewModel.routeToPickupLocation else { return }
            context.coordinator.configurePlyelineToPickupLocation(withRoute: route)
            context.coordinator.addAndSelectAnnotation(withCoordinate: trip.pickupLocation.toCoordinate())
            
        default:
            break 
         }
    }
    
    
    func makeCoordinator() -> MapCoordinator {
        return MapCoordinator(parent: self)
    }
}

extension UberMapViewRepresentable {
    class MapCoordinator: NSObject, MKMapViewDelegate {
        
        // MARK: - Properties
        
        let parent: UberMapViewRepresentable
        var userLocationCoordinate: CLLocationCoordinate2D?
        var currentRegion: MKCoordinateRegion?
        
        // MARK: - Lifecycle
        
        init(parent: UberMapViewRepresentable) {
            self.parent = parent
            super.init()
        }
        
        
        // MARK: - MKMapViewDelegate
        
        func mapView(_ mapView: MKMapView, didUpdate userLocation: MKUserLocation) {
            self.userLocationCoordinate = userLocation.coordinate
//            let newYorkCoordinate = CLLocationCoordinate2D(latitude: 40.7128, longitude: -74.0060)
            let region = MKCoordinateRegion(center: CLLocationCoordinate2D(latitude: userLocation.coordinate.latitude, longitude: userLocation.coordinate.longitude), span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05))
            
            self.currentRegion = region
            
            parent.mapView.setRegion(region, animated: true)
        }
        
        func mapView(_ mapView: MKMapView, rendererFor overlay: any MKOverlay) -> MKOverlayRenderer {
            let polyline = MKPolylineRenderer(overlay: overlay)
            polyline.strokeColor = .systemBlue
            polyline.lineWidth = 6
            return polyline
        }
        
        func mapView(_ mapView: MKMapView, viewFor annotation: any MKAnnotation) -> MKAnnotationView? {
            if let annotation = annotation as? DriverAnnotation {
                let view = MKAnnotationView(annotation: annotation, reuseIdentifier: "driver")
                
                view.image = UIImage(named: "chvron-sign-to-right")
                return view
            }
            
            return nil
        }
        
        //MARK: - Helpers
        
        func configurePlyelineToPickupLocation(withRoute route: MKRoute) {
            self.parent.mapView.addOverlay(route.polyline)
            let rect = self.parent.mapView.mapRectThatFits(route.polyline.boundingMapRect, edgePadding: .init(top: 90, left: 32, bottom: 400, right: 32))
            
            self.parent.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
        }
        
        func addAndSelectAnnotation(withCoordinate coordinate: CLLocationCoordinate2D) {
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            let anno = MKPointAnnotation()
            anno.coordinate = coordinate
            parent.mapView.addAnnotation(anno)
            parent.mapView.selectAnnotation(anno, animated: true)
        }
        
        func configurePolyline(withDestinationCoordinate coordinate: CLLocationCoordinate2D) {
            
            guard let userLocationCoordinate = self.userLocationCoordinate else { return }
            parent.homeViewModel.getDestinationRoute(from: userLocationCoordinate, to: coordinate) { route in
                self.parent.mapView.addOverlay(route.polyline)
                self.parent.mapState = .polylineAdded
                let rect = self.parent.mapView.mapRectThatFits(route.polyline.boundingMapRect, edgePadding: .init(top: 64, left: 32, bottom: 500, right: 32))
                
                self.parent.mapView.setRegion(MKCoordinateRegion(rect), animated: true)
            }
        }
        
        func clearMapViewAndRecenterOnUserLocation () {
            parent.mapView.removeAnnotations(parent.mapView.annotations)
            parent.mapView.removeOverlays(parent.mapView.overlays )
            
            if let currentRegion = currentRegion {
                parent.mapView.setRegion(currentRegion, animated: true )
            }
        }
        
        
        func addDriversToMap(_ drivers: [User]) {
            
            let driverAnno = drivers.map({ DriverAnnotation(driver: $0) })
            self.parent.mapView.addAnnotations(driverAnno)
        }
    }
}
