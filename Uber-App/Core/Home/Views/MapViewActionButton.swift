//
//  MapViewActionButton.swift
//  Uber-App
//
//  Created by Haider Muhammed on 5/31/25.
//

import SwiftUI

struct MapViewActionButton: View {
    
    @Binding var mapState: MapViewState
    @Binding var showSideMenu: Bool
    @EnvironmentObject var homeViewModel: HomeViewModel
    @EnvironmentObject var authViewModel: AuthViewModel
    
    var body: some View {
        Button {
            withAnimation(.spring()) {
                actionForState(mapState)
            }
        } label: {
            Image(systemName: imageNameForState(mapState))
                .font(.title2)
                .foregroundStyle(.black)
                .padding()
                .background(Color.white)
                .clipShape(Circle())
                .shadow(color: .black, radius: 6)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
    }
    
    func actionForState(_ state: MapViewState) {
        switch state {
        case .noInput:
            showSideMenu.toggle()
        case .searchingForLocation:
            mapState = .noInput
        case .locationSelected,
                .polylineAdded,
                .tripRequested,
                .tripAccepted,
                .tripRejected,
                .tripCancelldByDriver,
                .tripCancelldByPassenger:
            mapState = .noInput
            homeViewModel.selectedUberLocation = nil
        }
    }
    
    func imageNameForState(_ state: MapViewState) -> String {
        switch state {
        case .noInput:
            return "line.3.horizontal"
        case .searchingForLocation,
                .locationSelected,
                .polylineAdded,
                .tripRequested,
                .tripAccepted,
                .tripRejected,
                .tripCancelldByDriver,
                .tripCancelldByPassenger:
            return "arrow.left"
        }
    }
}

#Preview {
    MapViewActionButton(mapState: .constant(.searchingForLocation ), showSideMenu: .constant(false))
}
