//
//  HomeView.swift
//  Uber-App
//
//  Created by Haider Muhammed on 5/30/25.
//

import SwiftUI

struct HomeView: View {
    
    @State private var mapState = MapViewState.noInput
    @State private var showSideMenu = false
//    @EnvironmentObject var locationViewModel: LocationSearchViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    @EnvironmentObject var homeViewModel:  HomeViewModel
    
    
    var body: some View {
        Group {
            if authViewModel.userSession == nil {
                LoginView()
            } else if let user = authViewModel.currentUser {
                
                NavigationStack {
                    ZStack {
                        if showSideMenu {
                            SideMenuView(user: user)
                        }
                        
                        mapView
                            .offset(x: showSideMenu ? 316 : 0)
                            .shadow(color: showSideMenu ? .black : .clear, radius: 10)
                    }
                }
                .onAppear {
                    showSideMenu = false
                }
                
            }
        }
    }
}

extension HomeView {
    var mapView: some View {
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
                
                MapViewActionButton(mapState: $mapState, showSideMenu: $showSideMenu)
                    .padding(.leading)
                    .padding(.top, 4)
            }
            
            if let user = authViewModel.currentUser {
                homeViewModel.viewForState(mapState, user: user)
                    .transition(.move(edge: .bottom ))
            }
        }
        .edgesIgnoringSafeArea(.bottom)
        .onReceive(LocationManager.shared.$userLocation) { location in
            if let location = location {
                homeViewModel.userLocation = location
            }
        }
        
        .onReceive(homeViewModel.$selectedUberLocation) { location in
            if location != nil {
                mapState = .locationSelected
            }
        }
        
        .onReceive(homeViewModel.$trip) { trip in
            guard let trip = trip else {
                self.mapState = .noInput
                return
            }
            
            withAnimation(.spring()) {
                switch trip.state {
                case .requested:
                    self.mapState = .tripRequested
                case .accepted:
                    self.mapState = .tripAccepted
                case .rejected:
                    self.mapState = .tripRejected
                case .driverCancelled:
                    self.mapState = .tripCancelldByDriver
                case .passengerCancelled:
                    self.mapState = .tripCancelldByPassenger
                }
                
                print("DEBUG: Map state updated to: \(self.mapState)")
            }
        }
    }
}

#Preview {
    HomeView()
        .environmentObject(AuthViewModel())
}
