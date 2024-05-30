//
//  HomeView.swift
//  Tournament
//
//  Created by Øyvind Hauge on 30/05/2024.
//

import SwiftUI

struct HomeView: View {
    
    @State private var showProfile = false
    
    var scoreboard: [String] = ["1", "2", "3", "abc", "", "", "", "", ""]
    
    var body: some View {
        
        ZStack {
            
            VStack {
                
                // header view
                HStack {
                    Text("Tietoevry Bordtennis")
                        .font(Font.system(size: 26, weight: .bold))
                        .foregroundStyle(.white)
                    
                    Spacer()
                    Button(action: profileButtonTapped) {
                        ZStack {
                            
                            Text("😄")
                                .font(Font.system(size: 24))
                                .padding(.all, 6)
                        }
                        
                        .background(RoundedRectangle(cornerRadius: 10).fill(.green))
                    }
                }
                .padding(.horizontal, 16)
                .background(.red)
                
                // tournament view
                VStack {
                    
                    // scoreboard
                    List {
                        
                        ForEach(scoreboard.indices, id: \.self) { index in
                            PlayerViewV2(index: index)
                                .listRowInsets(EdgeInsets())
                                .listRowSeparator(.hidden)
                                .padding(.horizontal, 16)
                                .background(.white)
                        }
                    }
                    .listStyle(.plain)
                    .listRowSpacing(16)
                    
                    Spacer()
                    
                    // bottom menu
                    ZStack {
                        Button(action: {}) {
                            Text("Button")
                        }
                    }
                    .frame(maxWidth: .infinity)
                    .background(.green)
                }
                .frame(maxWidth: .infinity)
                .background(.white)
                .clipShape(
                    .rect(
                        topLeadingRadius: 16,
                        topTrailingRadius: 16
                    )
                )
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.blue)
    }
    
    private func profileButtonTapped() {
        showProfile.toggle()
    }
}

private struct PlayerViewV2: View {
    
    let index: Int
    
    var body: some View {
        
        HStack {
            
            Text("\(index + 1)")
                .font(Font.system(size: 17, weight: .heavy))
                .foregroundStyle(.gray)
                .padding(.trailing, 8)
            
            ZStack {
                Text("🤩")
                    .font(Font.system(size: 24))
                    .padding(.all, 6)
            }
            .background(Circle().fill(.gray))
            .padding(.trailing, 8)
            
            VStack {
                
                Text("oyvind_h")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(Font.system(size: 18, weight: .bold))
                    .padding(.bottom, 1)
                
                Text("1800 pts")
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .font(Font.system(size: 15, weight: .semibold))
                    .foregroundStyle(.gray)
            }
            .frame(maxWidth: .infinity)
            
            Spacer()
            
            Text("3")
                .font(Font.system(size: 17, weight: .bold))
                .foregroundStyle(.black)
            
            Text("3")
                .font(Font.system(size: 17, weight: .bold))
                .foregroundStyle(.black)
                .padding(.leading, 26)
        }
    }
}

#Preview {
    HomeView()
}
