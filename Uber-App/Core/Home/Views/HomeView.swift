//
//  HomeView.swift
//  Uber-App
//
//  Created by Haider Muhammed on 5/30/25.
//

import SwiftUI

struct HomeView: View {
    var body: some View {
        UberMapViewRepresentable()
            .ignoresSafeArea(edges: .all)
    }
}

#Preview {
    HomeView()
}
