//
//  CustomInputField.swift
//  Uber-App
//
//  Created by Haider Muhammed on 6/1/25.
//

import SwiftUI

struct CustomInputField: View {
    
    @Binding var text: String
    let title: String
    let placholder: String
    var isScureField = false
    
    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text(title)
                .foregroundStyle(.white)
                .fontWeight(.semibold)
                .font(.footnote)
            
            if isScureField {
                SecureField(placholder, text: $text)
                    .foregroundStyle(.white)
            } else {
                TextField(placholder, text: $text)
                    .foregroundStyle(.white)
            }
            
            Rectangle()
                .foregroundStyle(Color(.init(white: 1, alpha: 0.3)))
                .frame(width: UIScreen.main.bounds.width - 32, height: 0.7)
        }
    }
}

#Preview {
    CustomInputField(text: .constant(""), title: "Email Address", placholder: "name@example.com")
}
