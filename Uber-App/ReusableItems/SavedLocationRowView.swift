//
//  SavedLocationRowView.swift
//  Uber-App
//
//  Created by Haider Muhammed on 6/2/25.
//

import SwiftUI

struct SavedLocationRowView: View {
    
    let viewModel: SavedLcationViewModel
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: viewModel.imageName)
                .imageScale(.medium)
                .font(.title)
                .foregroundStyle(Color(.systemBlue))
            
            VStack(alignment: .leading, spacing:  4) {
                Text(viewModel.title)
                    .font(.system(size: 15, weight: .semibold))
                    .foregroundStyle(.black)
                
                Text(viewModel.subtitle)
                    .font(.system(size: 14))
                    .foregroundStyle(.gray)
            }
        }
    }
}

#Preview {
    SavedLocationRowView(viewModel: SavedLcationViewModel.home)
}
