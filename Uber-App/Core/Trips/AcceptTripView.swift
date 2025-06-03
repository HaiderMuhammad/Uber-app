//
//  AcceptTripView.swift
//  Uber-App
//
//  Created by Haider Muhammed on 6/3/25.
//

import SwiftUI
import MapKit

struct AcceptTripView: View {
    
    @State private var cameraPosition: MapCameraPosition
    let trip: Trip
    let annotationItem: UberLocation
    
    init(trip: Trip) {
        let center = CLLocationCoordinate2D(latitude: trip.pickupLocation.latitude, longitude: trip.pickupLocation.longitude)
        let span = MKCoordinateSpan(latitudeDelta: 0.025, longitudeDelta: 0.025)
        
        
        
        
        self.cameraPosition = MapCameraPosition.region(MKCoordinateRegion(
            center: center, span: span))
        
        self.trip = trip
        self.annotationItem = UberLocation(title: trip.pickupLocationName, coordinate: trip.pickupLocation.toCoordinate())
    }
    
    var body: some View {
        VStack {
            Capsule()
                .foregroundStyle(Color(.systemGray5))
                .frame(width: 48, height: 6)
                .padding(.top, 8 )
            
            
            // would like to pickup view
            VStack {
                HStack {
                    Text("Would you like to pickup this passenger?")
                        .font(.headline)
                        .fontWeight(.semibold)
                        .lineLimit(2)
                        .multilineTextAlignment(.leading)
                        .frame(height: 50)
                    
                    Spacer()
                    
                    // travel
                    VStack {
                        Text("\(trip.travelTimeToPasseneger)")
                            .bold()
                        
                        Text("min")
                    }
                    .frame(width: 56, height: 56)
                    .bold()
                    .foregroundStyle(.white)
                    .background(Color(.systemBlue))
                    .clipShape(.rect(cornerRadius: 10))
                }
                .padding()
                
                Divider()
            }
            
            
            // user info view
            VStack {
                HStack {
                    Image("male-profile-photo")
                        .resizable()
                        .scaledToFill()
                        .frame(width: 80, height: 80)
                        .clipShape(Circle())
                    
                    VStack(alignment: .leading, spacing: 4) {
                        Text(trip.passengerName)
                            .fontWeight(.bold)
                        
                        HStack {
                            Image(systemName: "star.fill")
                                .foregroundStyle(Color(.systemYellow))
                                .imageScale(.small)
                            
                            Text("4.8")
                                .font(.footnote)
                                .foregroundStyle(.gray)
                        }
                    }
                    
                    Spacer()
                    
                    VStack(spacing: 6) {
                        Text("Earnings")
                            
                        Text(trip.tripCost.toCurrency())
                            .font(.system(size: 24, weight: .semibold))
                        
                    }
                    
                }
                
                Divider()
                
                
            }
            .padding( )
            
            // pickup location info view
            
            VStack {
                // trip location info
                HStack {
                    // address info
                    VStack(alignment: .leading, spacing: 6) {
                        Text(trip.pickupLocationName)
                            .font(.headline)
                        
                        Text(trip.pickupLocationAddress)
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                    }
                    
                    Spacer()
                    
                    // distance
                    VStack {
                        Text(trip.distanceToPassenger.distanceInMilesString())
                            .font(.headline)
                            .fontWeight(.semibold)
                        
                        Text("mi")
                            .font(.subheadline)
                            .foregroundStyle(.gray)
                    }
                }
                .padding(.horizontal)
                
                // map
                Map(position: $cameraPosition) {
                    Marker("", coordinate: annotationItem.coordinate)
                }
                    .frame(height: 220)
                    .clipShape(.rect(cornerRadius: 10))
                    .shadow(color: .black.opacity(0.6), radius: 4)
                    .padding()
                
                
                // divider
                
                Divider()
            }
            
            
            // action button
            
            HStack {
                Button {
                    
                }label: {
                    Text("Reject")
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding()
                        .frame(width: (UIScreen.main.bounds.width / 2) - 32, height: 56)
                        .background(Color(.systemRed))
                        .clipShape(.rect(cornerRadius: 10))
                        .foregroundStyle(.white)
                    
                }
                
                Spacer()
                
                Button {
                    
                }label: {
                    Text("Accept")
                        .font(.headline)
                        .fontWeight(.bold)
                        .padding()
                        .frame(width: (UIScreen.main.bounds.width / 2) - 32, height: 56)
                        .background(Color(.systemBlue))
                        .clipShape(.rect(cornerRadius: 10))
                        .foregroundStyle(.white)
                }
            }
            .padding(.top)
            .padding(.horizontal)
            .padding(.bottom, 24)
        }
        .background(Color(.white))
        .clipShape(.rect(cornerRadius: 16))
        .shadow(color: Color(.systemBackground), radius: 20)
    }
}

#Preview {
    AcceptTripView(trip: DeveloperPreview.shared.mockTrip)
}
