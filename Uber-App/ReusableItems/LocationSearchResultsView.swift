//
//  LocationSearchResultsView.swift
//  Uber-App
//
//  Created by Haider Muhammed on 6/2/25.
//

import SwiftUI

struct LocationSearchResultsView: View {
    
    @StateObject var viewModel: HomeViewModel
    let config: LocationResultsViewConfig
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading) {
                ForEach(viewModel.results, id: \.self) { result in
                    LocationSearchResultCell(title: result.title, subtitle: result.subtitle)
                        .onTapGesture {
                            withAnimation(.spring()) {
                                viewModel.selectLocation(result, config: config)
                                
                            }
                        }
                }
            }
        }
    }
}
