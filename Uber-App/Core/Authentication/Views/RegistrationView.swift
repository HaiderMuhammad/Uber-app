//
//  RegistrationView.swift
//  Uber-App
//
//  Created by Haider Muhammed on 6/1/25.
//

import SwiftUI

struct RegistrationView: View {
    
    @State private var fullname = ""
    @State private var email = ""
    @State private var password = ""
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var authViewModel: AuthViewModel
    
    var body: some View {
        ZStack {
            Color(.black)
                .ignoresSafeArea()
            
            VStack(alignment: .leading, spacing: 20) {
                Button {
                    dismiss()
                } label: {
                    Image(systemName: "arrow.left")
                        .font(.title)
                        .imageScale(.medium)
                        .padding()
                }
                
                Text("Create new account")
                    .font(.system(size: 40, weight: .semibold))
                    .multilineTextAlignment(.leading)
                    .frame(width: 250)
                
                Spacer()
                
                VStack {
                    VStack(spacing: 56) {
                        CustomInputField(text: $fullname,
                                         title: "Full name",
                                         placholder: "Enter your name")
                        
                        CustomInputField(text: $email,
                                         title: "Email Address",
                                         placholder: "example@gmail.com")
                        
                        CustomInputField(text: $password,
                                         title: "Create Password",
                                         placholder: "Enter your password",
                                         isScureField: true)
                    }
                    .padding(.leading )
                    
                    Spacer()
                    // sign up
                    
                    Button{
                        
                        authViewModel.registerUser(withEmail: <#T##String#>, password: <#T##String#>, fullname: <#T##String#>)
                        
                    } label: {
                        HStack {
                            Text("SIGN UP")
                                .foregroundStyle(.black)
                            
                            Image(systemName: "arrow.right")
                                .foregroundStyle(.black)
                        }
                        .frame(width: UIScreen.main.bounds.width - 32, height: 50)
                    }
                    .background(.white)
                    .cornerRadius(10)
                    
                    Spacer()
                }
                
                
            }
            .foregroundStyle(.white)
        }
    }
}

#Preview {
    RegistrationView()
}
