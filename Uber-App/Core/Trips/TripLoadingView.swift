//
//  TripLoadingView.swift
//  Uber-App
//
//  Created by Haider Muhammed on 6/4/25.
//

import SwiftUI

struct TripLoadingView: View {
    var body: some View {
        VStack {
            Text("Finding your ride...")
                .padding()
        }
        .background(Color(.white))
        .clipShape(.rect(cornerRadius: 16))
        .shadow(color: Color(.systemBackground), radius: 20)
    }
}

#Preview {
    TripLoadingView()
}
