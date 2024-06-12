//
//  HeaderView.swift
//  Tournament
//
//  Created by Øyvind Hauge on 05/06/2024.
//

import SwiftUI

struct HeaderView: View {
    
    @Binding var account: Account?
    @Binding var title: String
    @Binding var playerFilter: String
    @Binding var btBroadcastingState: BroadcastingState
    @Binding var showProfile: Bool
    
    var body: some View {
        
        VStack {
            
            // top part
            HStack {
                Text(title)
                    .font(Font.system(size: 26, weight: .bold))
                    .foregroundStyle(.white)
                
                Spacer()
                Button(action: profileTapped) {
                    ZStack {
                        
                        Text(account?.emoji ?? "🫠")
                            .font(Font.system(size: 22))
                            .padding(.all, 6)
                        
                        /*
                        HStack {
                            Spacer()
                            Circle()
                                .fill(.blue)
                                .frame(width: 20, height: 20)
                        }
                         */
                    }
                    .background(RoundedRectangle(cornerRadius: 10).fill(.green))
                }
            }
            
            // search field
            HStack {
                
                Image(systemName: "magnifyingglass")
                    .font(Font.system(size: 18, weight: .medium))
                    .foregroundStyle(.white.opacity(0.7))
                    .padding(.leading, 16)
                    .padding(.trailing, 8)
                
                TextField("", text: $playerFilter, prompt: Text("Filter players...").foregroundStyle(.white.opacity(0.7)))
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
                    .keyboardType(.alphabet)
                    .font(Font.system(size: 18, weight: .medium))
                    .foregroundStyle(.white)
                    .background(.clear)
                    .padding(.trailing, 16)
                    .padding(.vertical, 12)
            }
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 15).fill(.white).opacity(0.2))
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 8)
    }
    
    private func profileTapped() {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        showProfile.toggle()
    }
}
