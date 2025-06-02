//
//  SettingsRowView.swift
//  Uber-App
//
//  Created by Haider Muhammed on 6/2/25.
//

import SwiftUI

struct SettingsRowView: View {
    
    let imageName: String
    let title: String
    let tintColor: Color
    
    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: imageName)
                .imageScale(.medium)
                .font(.title)
                .foregroundStyle(tintColor)
            
            Text(title)
                .font(.system(size: 15, weight: .semibold))
                .foregroundStyle(.black)
        }
    }
}

#Preview {
    SettingsRowView(imageName: "", title: "", tintColor: .blue)
}
