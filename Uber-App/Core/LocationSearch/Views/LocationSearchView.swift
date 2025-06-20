//
//  LocationSearchView.swift
//  Uber-App
//
//  Created by Haider Muhammed on 5/31/25.
//

import SwiftUI

struct LocationSearchView: View {
    
    @State private var startLocationText: String = ""
    @Binding var mapState: MapViewState
    @EnvironmentObject var viewModel: HomeViewModel
    
    var body: some View {
        VStack {
            // header view
            HStack {
                VStack {
                    Circle()
                        .fill(Color(.systemGray3))
                        .frame(width: 6, height: 6)
                    
                    Rectangle()
                        .fill(Color(.systemGray3))
                        .frame(width: 1, height: 24)
                    
                    Rectangle()
                        .fill(Color(.black))
                        .frame(width: 6, height: 6 )
                    
                }
                
                VStack {
                    TextField("Current Location", text: $startLocationText)
                        .frame(height: 32)
                        .background(Color(.systemGroupedBackground))
                        .padding(.trailing)
                    
                    TextField("Where to?", text: $viewModel.queryFragment)
                        .frame(height: 32)
                        .background(Color(.systemGray4))
                        .padding(.trailing)
                        
                }
            }
            .padding(.horizontal)
            .padding(.top, 64)
            
            Divider()
                .padding(.vertical)
            
            
            // list view
            
            LocationSearchResultsView(viewModel: viewModel, config: .ride)
        }
        .background(Color(.systemBackground))
        .background(.white)
    }
}

#Preview {
    LocationSearchView(mapState: .constant(.searchingForLocation))
}


