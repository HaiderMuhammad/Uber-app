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
                userInfoSection
                favoritesSection
                settingsSection
                accountSection
            }
        }
        .navigationTitle("Settings")
        .navigationBarTitleDisplayMode(.large)
    }
    
    private var userInfoSection: some View {
        Section {
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
    }
    
    private var favoritesSection: some View {
        Section("Favorites") {
            ForEach(SavedLcationViewModel.allCases) { viewModel in
                NavigationLink {
                    SavedLocationSearchView()
                } label: {
                    SavedLocationRowView(viewModel: viewModel)
                }
            }
        }
    }
    
    private var settingsSection: some View {
        Section("Settings") {
            SettingsRowView(imageName: "bell.circle.fill",
                            title: "Notifications",
                            tintColor: .purple)
            
            SettingsRowView(imageName: "creditcard.circle.fill",
                            title: "Payment Methods",
                            tintColor: .blue)
        }
    }
    
    private var accountSection: some View {
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

