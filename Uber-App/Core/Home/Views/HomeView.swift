//
//  HomeView.swift
//  Uber-App
//
//  Created by Haider Muhammed on 5/30/25.
//

import SwiftUI

struct HomeView: View {
    
    @State private var mapState = MapViewState.noInput
    @EnvironmentObject var locationViewModel: LocationSearchViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    
    
    var body: some View {
        Group {
            if authViewModel.userSession == nil {
                LoginView()
            } else {
                ZStack(alignment: .bottom) {
                    ZStack(alignment: .top) {
                        UberMapViewRepresentable(mapState: $mapState)
                            .ignoresSafeArea(edges: .all)
                        
                        if mapState == .searchingForLocation {
                            LocationSearchView(mapState: $mapState)
                        } else if mapState == .noInput  {
                            LocationSearchActivationView()
                                .padding(.top, 70)
                                .onTapGesture {
                                    withAnimation(.spring()) {
                                        mapState = .searchingForLocation
                                    }
                                }
                        }
                        
                        MapViewActionButton(mapState: $mapState)
                            .padding(.leading)
                            .padding(.top, 4)
                    }
                    
                    if mapState == .locationSelected || mapState == .polylineAdded {
                        RideRequestView()
                            .transition(.move(edge: .bottom))
                    }
                }
                .edgesIgnoringSafeArea(.bottom)
                .onReceive(LocationManager.shared.$userLocation) { location in
                    if let location = location {
                        locationViewModel.userLocation = location
                    }
                }
            }
        }
    }
}

#Preview {
    HomeView()
}
