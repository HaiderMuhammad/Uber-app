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
            Capsule()
                .foregroundStyle(Color(.systemGray5))
                .frame(width: 48, height: 6)
                .padding(.top, 8)
            HStack {
                VStack(alignment: .leading, spacing: 12) {
                    Text("Connecting you to a driver")
                        .font(.headline)
                    
                    Text("Arriving at 1:30 PM ")
                        .font(.subheadline)
                        .fontWeight(.semibold)
                        .foregroundStyle(Color(.systemBlue))
                }
                .padding()
                
                Spacer()
                
                Spinner(lineWidth: 6, heigth: 64, width: 64)
                    .padding()
            }
            .padding(.bottom, 24)
        }
        .background(Color(.white))
        .clipShape(.rect(cornerRadius: 16))
        .shadow(color: Color(.secondarySystemBackground), radius: 20)
    }
}

#Preview {
    TripLoadingView()
}
