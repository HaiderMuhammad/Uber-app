//
//  TripCancelledView.swift
//  Uber-App
//
//  Created by Haider Muhammed on 6/7/25.
//

import SwiftUI

struct TripCancelledView: View {
    
    @EnvironmentObject var viewModel: HomeViewModel
    var body: some View {
        VStack {
            Capsule()
                .foregroundStyle(Color(.systemGray5))
                .frame(width: 48, height: 6)
                .padding(.top,8)
            
            Text(viewModel.tripCancelledMessage)
                .font(.headline )
                .padding(.vertical)
            
            
            Button {
                guard let user = viewModel.currentUser else { return }
                guard let trip = viewModel.trip else { return }
                
                if user.accountType == .passenger {
                    if trip.state == .driverCancelled {
                        viewModel.deleteTrip()
                    } else if trip.state == .passengerCancelled {
                        viewModel.trip = nil
                    }
                } else {
                    if trip.state == .passengerCancelled {
                        viewModel.deleteTrip()
                    } else if trip.state == .driverCancelled {
                        viewModel.trip = nil
                    }
                }
                
            } label: {
                 Text("OK")
                    .fontWeight(.bold)
                    .frame(width: UIScreen.main.bounds.width - 32, height: 50)
                    .background(.red)
                    .cornerRadius(10)
                    .foregroundStyle(.white)
                    
            }
        }
        .padding(.bottom, 24)
        .frame(maxWidth: .infinity)
        .background(Color(.systemBackground))
        .clipShape(.rect(cornerRadius: 16))
        .shadow(color: Color(.secondarySystemBackground), radius: 20)
    }
}

#Preview {
    TripCancelledView()
}
