//
//  SettingsView.swift
//  Uber-App
//
//  Created by Haider Muhammed on 6/2/25.
//

import SwiftUI

struct SettingsView: View {
    
    private let user: User
    @EnvironmentObject private var viewModel: AuthViewModel
    
    init(user: User) {
        self.user = user
    }
    
    var body: some View {
        VStack {
            List {
                Section {
                    // user info header
                    HStack {
                        Image("male-profile-photo")
                            .resizable()
                            .scaledToFill()
                            .clipShape(Circle())
                            .frame(width: 64, height: 64)
                        
                        VStack(alignment: .leading, spacing: 8) {
                            Text(user.fullName)
                                .font(.system(size: 16, weight: .semibold))
                            
                            Text(user.email)
                                .font(.system(size: 14))
                                .tint(.black)
                                .opacity(0.77)
                        }
                        
                        Spacer()
                        
                        Image(systemName: "chevron.right")
                            .imageScale(.small)
                            .font(.title2)
                            .foregroundStyle(.gray)
                    }
                    .padding(8)
                }
                
                Section("Favorites") {
                    SavedLocationRowView(imageName: "house.circle.fill",
                                         title: "Home",
                                         subtitle: "Add Home")
                    
                    SavedLocationRowView(imageName: "archivebox.circle.fill",
                                         title: "Work",
                                         subtitle: "Add Work")
                }
                
                Section("Settings") {
                    SettingsRowView(imageName: "bell.circle.fill",
                                    title: "Notifications",
                                    tintColor: .purple)
                    
                    SettingsRowView(imageName: "creditcard.circle.fill",
                                    title: "Payment Methods",
                                    tintColor: .blue)
                }
                
                Section("Account") {
                    SettingsRowView(imageName: "dollarsign.square.fill",
                                    title: "Make Money Driving",
                                    tintColor: .green)
                    
                    SettingsRowView(imageName: "arrow.left.square.fill",
                                    title: "Sign Out",
                                    tintColor: .red)
                    .onTapGesture {
                        viewModel.signout()
                    }
                }
            }
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.large)
    }
}

#Preview {
    NavigationStack {
        SettingsView(user: User(fullName: "Arthur Morgen",
                                email: "arthur@gmail.com",
                                uid: "1212343"))
    }
}
