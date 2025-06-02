//
//  SavedLocationSearchView.swift
//  Uber-App
//
//  Created by Haider Muhammed on 6/2/25.
//

import SwiftUI

struct SavedLocationSearchView: View {
    
    @StateObject private var viewModel = LocationSearchViewModel()
    let config: SavedLcationViewModel
    var body: some View {
        VStack {
            HStack(spacing: 16) {
                Image(systemName: "arrow.left")
                    .font(.title2)
                    .imageScale(.medium)
                    .padding(.leading)
                
                TextField("Search for a location..", text: $viewModel.queryFragment)
                    .frame(height: 32)
                    .padding(.leading)
                    .background(Color(.systemGray5))
                    .padding(.trailing)
            }
            .padding(.top)
            
            Spacer()
            
            LocationSearchResultsView(viewModel: viewModel, config: .saveLocation(config))
        }
        .navigationTitle(config.subtitle)
    }
}

#Preview {
    NavigationStack {
        SavedLocationSearchView(config: .home)
    }
}
