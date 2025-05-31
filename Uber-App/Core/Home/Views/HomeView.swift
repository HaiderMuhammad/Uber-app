//
//  HomeView.swift
//  Uber-App
//
//  Created by Haider Muhammed on 5/30/25.
//

import SwiftUI

struct HomeView: View {
    
    @State private var showSearchBar: Bool = false
    
    var body: some View {
        ZStack(alignment: .top) {
            UberMapViewRepresentable()
                .ignoresSafeArea(edges: .all)
            
            if showSearchBar {
                LocationSearchView(showLocationSearchView: $showSearchBar)
            } else {
                LocationSearchActivationView()
                    .padding(.top, 70)
                    .onTapGesture {
                        withAnimation(.spring()) {
                            showSearchBar.toggle()
                        }
                    }
            }
            
            MapViewActionButton(showLocationSearchView: $showSearchBar)
                .padding(.leading)
                .padding(.top, 4)
        }
    }
}

#Preview {
    HomeView()
}
