//
//  TripAcceptedView.swift
//  Uber-App
//
//  Created by Haider Muhammed on 6/4/25.
//

import SwiftUI

struct TripAcceptedView: View {
    
    @EnvironmentObject var homeViewModel: HomeViewModel
    var body: some View {
        VStack {
            
            Capsule()
                .foregroundStyle(Color(.systemGray5))
                .frame(width: 48, height: 6)
                .padding(.top, 8)
            
            
            if let trip = homeViewModel.trip {
                
                // pickup info view
                VStack {
                    HStack {
                        Text("Meet your driver at \(trip.pickupLocationName) for your trip to \(trip.dropoffLocationName )")
                            .font(.body)
                            .frame(height: 47)
                            .lineLimit(2)
                            .padding(.trailing)
                        
                        Spacer()
                        
                        VStack {
                            Text("\(trip.travelTimeToPasseneger)")
                                .bold()
                            
                            Text("min")
                                .bold()
                        }
                        .frame(width: 56, height: 56)
                        .foregroundStyle(.white)
                        .background(Color(.systemBlue))
                        .clipShape(.rect(cornerRadius: 10))
                    }
                    .padding()
                    
                    Divider()
                }
                
                // f]driver info view
                
                VStack {
                    HStack {
                        Image("male-profile-photo")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 80, height: 80)
                            .clipShape(Circle())
                        
                        VStack(alignment: .leading, spacing: 4) {
                            Text(trip.driverName)
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
                        
                        
                        // driver vehical info
                        VStack(alignment: .center) {
                            Image("uber-x")
                                .resizable()
                                .scaledToFill()
                                .frame(width: 120, height: 64)
                            
                            HStack {
                                Text("Mercedes S -")
                                    .font(.system(size: 14, weight: .semibold))
                                    .foregroundStyle(.gray)
                                Text("5G4k08")
                                    .font(.system(size: 14, weight: .semibold))
                                
                            }
                            .frame(width: 160)
                            .padding(.bottom  )
                        }
                    
                    }
                    
                    Divider()
                }
                .padding()
            }
            
            Button {
                homeViewModel.cancelTripAsPassenger()
                
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
    TripAcceptedView()
}
