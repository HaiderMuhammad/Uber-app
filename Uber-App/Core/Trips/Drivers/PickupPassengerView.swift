//
//  PickupPassengerView.swift
//  Uber-App
//
//  Created by Haider Muhammed on 6/5/25.
//

import SwiftUI

struct PickupPassengerView: View {
    
    let trip: Trip
    
    var body: some View {
        VStack {
            Capsule()
                .foregroundStyle(Color(.systemGray5))
                .frame(width: 48, height: 6)
                .padding(.top, 8)
            
            // would like to pickup view
            VStack {
                HStack {
                    Text("Pickup \(trip.passengerName) at \(trip.dropoffLocationName)")
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
                                
                            Text("\(trip.tripCost.toCurrency())")
                                .font(.system(size: 24, weight: .semibold))
                            
                        }
                        
                    }
                    
                    Divider()
                    
                    
                    
                    
                }
                .padding( )
            }
            .padding()
            
            Button {
                print("DEBUG: Cancel Trip")
                
            } label: {
                 Text("CANCEL TRIP")
                    .fontWeight(.bold)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 50)
                    .background(.red)
                    .cornerRadius(10)
                    .foregroundStyle(.white)
                    
            }
        }
        .padding(.bottom, 24)
        .background(Color(.white))
        .clipShape(.rect(cornerRadius: 16))
        .shadow(color: Color(.systemBackground), radius: 20)
    }
}

#Preview {
    PickupPassengerView(trip: DeveloperPreview.shared.mockTrip)
}
