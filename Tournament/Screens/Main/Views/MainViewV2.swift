//
//  MainView.swift
//  Tournament
//
//  Created by Øyvind Hauge on 05/05/2024.
//

import SwiftUI

struct MainViewV2: View {
    
    @State private var show = true
    
    var body: some View {
        
        VStack(spacing: 0) {
            
            // background view (register match)
            ZStack {
                
                RegisterMatchView()
                
                if show {
                    
                    // tournament view
                    VStack {
                        
                        ScoreboardView()
                    }
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .background(Color.General.defaultBackground)
                    .transition(.move(edge: .bottom))
                }
            }
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(.yellow)
            
            // bottom menu
            HStack {
                
                Button(action: toggleShow) {
                    Text("Register Match")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(MainButtonStyle())
                .padding(.leading, 16)
                .padding(.top, 16)
                
                Button(action: {}) {
                    Image(systemName: "gearshape.fill")
                }
                .buttonStyle(SecondaryButtonStyle())
                .padding(.trailing, 16)
                .padding(.top, 16)
            }
            .frame(maxWidth: .infinity)
            .safeAreaPadding(.bottom, 32)
            .background(Color.white
                .shadow(color: Color.gray, radius: 5, x: 0, y: 0)
                .mask(Rectangle().padding(.top, -20)))
        }
    }
    
    private func toggleShow() {
        withAnimation { show.toggle() }
    }
}

#Preview {
    MainViewV2()
}
