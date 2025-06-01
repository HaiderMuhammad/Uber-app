//
//  SideMenuView.swift
//  Uber-App
//
//  Created by Haider Muhammed on 6/1/25.
//

import SwiftUI

struct SideMenuView: View {
    var body: some View {
        VStack(spacing: 40) {
            
            // header view
            VStack(alignment: .leading, spacing: 32) {
                // user info
                HStack {
                    Image("male-profile-photo")
                        .resizable()
                        .scaledToFill()
                        .clipShape(Circle())
                        .frame(width: 64, height: 64)
                    
                    VStack(alignment: .leading, spacing: 8) {
                        Text("Arthur Morgen")
                            .font(.system(size: 16, weight: .semibold))
                        
                        Text("arthur@gmail.com")
                            .font(.system(size: 14))
                            .tint(.black)
                            .opacity(0.77)
                    }
                }
                
                // become a driver
                VStack(alignment: .leading, spacing: 16) {
                    Text("Do more with your account")
                        .font(.footnote)
                        .fontWeight(.semibold)
                    
                    HStack {
                        Image(systemName: "dollarsign.square")
                            .font(.title2)
                            .imageScale(.medium)
                        
                        Text("MAke Money Driving")
                            .font(.system(size: 16, weight: .semibold))
                            .padding(6)
                    }
                }
                
                Divider()
                    .frame(width: 296)
                    .shadow(color: .black.opacity(0.7), radius: 4)
                
                
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding(.leading, 16)
            
            
            
            
            // option list
            VStack {
                ForEach(SideMenuViewModel.allCases) { viewModel in
                    SideMenuOptionView(viewModel: viewModel)
                        .padding()
                }
            }
            
            Spacer()
            
        }
        .padding(.top, 32)
    }
}

#Preview {
    SideMenuView()
}
