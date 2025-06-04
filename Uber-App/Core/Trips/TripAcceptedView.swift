//
//  TripAcceptedView.swift
//  Uber-App
//
//  Created by Haider Muhammed on 6/4/25.
//

import SwiftUI

struct TripAcceptedView: View {
    var body: some View {
        VStack {
            Text("Your driver is on their way ")
        }
        .background(Color(.white))
        .clipShape(.rect(cornerRadius: 16))
        .shadow(color: Color(.systemBackground), radius: 20)
    }
}

#Preview {
    TripAcceptedView()
}
