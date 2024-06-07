//
//  HeaderView.swift
//  Tournament
//
//  Created by Øyvind Hauge on 05/06/2024.
//

import SwiftUI

struct HeaderView: View {
    
    @Binding var title: String
    @Binding var playerFilter: String
    @Binding var showProfile: Bool
    
    var body: some View {
        
        VStack {
            
            // top part
            HStack {
                Text(title)
                    .font(Font.system(size: 26, weight: .bold))
                    .foregroundStyle(.white)
                
                Spacer()
                Button(action: {
                    showProfile.toggle()
                }) {
                    ZStack {
                        
                        Text("😍")
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
                TextField("Filter players...", text: $playerFilter)
                    .font(Font.system(size: 17, weight: .medium))
                    .foregroundStyle(.white)
                    .background(.clear)
                    .padding(.horizontal, 16)
                    .padding(.vertical, 10)
            }
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 15).fill(.white).opacity(0.2))
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 8)
    }
}
