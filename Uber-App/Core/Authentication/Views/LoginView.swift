//
//  LoginView.swift
//  Uber-App
//
//  Created by Haider Muhammed on 6/1/25.
//

import SwiftUI

struct LoginView: View {
    
    @State private var email = ""
    @State private var password = ""
    
    var body: some View {
        ZStack {
            Color(.black)
                .ignoresSafeArea()
            
            VStack {
                
                // image and title
                VStack {
                    // App icon
                    ZStack {
                            Circle()
                                .frame(width: 150, height: 150)
                                .foregroundStyle(.white)
                            
                        HStack(spacing: 0) {
                            
                            Rectangle()
                                .frame(width: 100, height: 15)
                                .foregroundStyle(.black)
                            
                            
                            Rectangle()
                                .frame(width: 42, height: 42)
                                .foregroundStyle(.black)
                                .cornerRadius(4)
                        }
                        .offset(x: -50)
                        }
                    
                    Text("UBER")
                        .foregroundStyle(.white)
                        .font(.largeTitle)
                }
                
                // input fields
                VStack(spacing: 32) {
                    VStack(alignment: .leading, spacing: 12) {
                        CustomInputField(text: $email,
                                         title: "Email Address",
                                         placholder: "email@example.com")
                        
                        CustomInputField(text: $password,
                                         title: "Password",
                                         placholder: "Enter Your Password",
                                         isScureField: true
                        )
                        
                            
                    }
                    
                    Button {
                        
                    } label: {
                        Text("Forget Password?")
                            .font(.system(size: 13, weight: .semibold))
                            .foregroundStyle(.white)
                            .padding(.top)
                    }
                    .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding(.horizontal)
                .padding(.top, 12)
                
                
                
                // soical sign in view
                VStack {
                    // divider + text
                    HStack(spacing: 24) {
                        Rectangle()
                            .frame(width:  76, height: 1)
                            .foregroundStyle(.white)
                            .opacity(0.5)
                        
                        Text("Sign in with social")
                            .foregroundStyle(.white)
                            .fontWeight(.semibold)
                        
                        Rectangle()
                            .frame(width:  76, height: 1)
                            .foregroundStyle(.white)
                            .opacity(0.5)
                    }
                    
                    // sign up button
                    
                    HStack(spacing: 24) {
                        Button{
                            
                        } label: {
                            Image("facebook-logo")
                                .resizable()
                                .frame(width: 40, height: 40)
                        }
                        
                        Button{
                            
                        } label: {
                            Image("google-logo")
                                .resizable()
                                .frame(width: 40, height: 40)
                        }
                    }
                }
                .padding(.vertical)
                
                Spacer()
                
                // sign in button
                Button{
                    
                } label: {
                    HStack {
                        Text("SIGN IN")
                            .foregroundStyle(.black)
                        
                        Image(systemName: "arrow.right")
                            .foregroundStyle(.black)
                    }
                    .frame(width: UIScreen.main.bounds.width - 32, height: 50)
                }
                .background(.white)
                .cornerRadius(10)
                
                
                Spacer()
                
                
                // sign up buuton
                
                Button{
                    
                } label: {
                    HStack {
                        Text("Don't have an account?")
                            .font(.system(size: 14))
                        
                        Text("Sign Up")
                            .font(.system(size: 14, weight: .semibold))
                    }
                    .foregroundStyle(.white)
                }
                
            }
        }
    }
}

#Preview {
    LoginView()
}
