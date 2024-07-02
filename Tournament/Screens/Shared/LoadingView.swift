//
//  LoadingView.swift
//  Tournament
//
//  Created by Øyvind Hauge on 02/07/2024.
//

import SwiftUI

struct LoadingView: View {
    
    let title: String
    let subtitle: String
    
    init(_ title: String, _ subtitle: String) {
        self.title = title
        self.subtitle = subtitle
    }
    
    var body: some View {
        
        VStack {
            
            Spacer()
            
            HStack {
                Spacer()
                
                Image(systemName: "network")
                    .renderingMode(.template)
                    .font(Font.system(size: 56))
                    .foregroundStyle(Color.General.mainBackground2)
                
                Spacer()
            }
            .padding(.top, 16)
            .padding(.bottom, 8)
            
            Text(title)
                .font(Font.system(size: 20, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .center)
                .multilineTextAlignment(.center)
                .foregroundStyle(Color.Text.normal)
                .padding(.horizontal, 16)
                .padding(.bottom, 2)
            
            Text(subtitle)
                .font(Font.system(size: 17, weight: .medium))
                .frame(maxWidth: .infinity, alignment: .center)
                .multilineTextAlignment(.center)
                .foregroundStyle(Color.Text.subtitle)
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
            
            Spacer()
        }
        .padding(.horizontal, 16)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

#Preview {
    LoadingView("Please wait", "Loading tournament data")
}
