//
//  ErrorView.swift
//  Tournament
//
//  Created by Øyvind Hauge on 26/04/2024.
//

import SwiftUI

struct ErrorView: View {
    
    var error: Error
    
    init(_ error: Error) {
        self.error = error
    }
    
    var body: some View {
        
        VStack {
            
            HStack {
                Spacer()
                
                Image(systemName: "flame")
                    .renderingMode(.template)
                    .font(Font.system(size: 56))
                
                Spacer()
            }
            .padding(.top, 16)
            .padding(.bottom, 8)
            
            Text("Oops! There was an error...")
                .font(Font.system(size: 20, weight: .bold, design: .rounded))
                .frame(maxWidth: .infinity, alignment: .center)
                .multilineTextAlignment(.center)
                .foregroundStyle(Color.Text.normal)
                .padding(.horizontal, 16)
                .padding(.bottom, 2)
            
            Text(error.localizedDescription)
                .font(Font.system(size: 17, weight: .medium, design: .rounded))
                .frame(maxWidth: .infinity, alignment: .center)
                .multilineTextAlignment(.center)
                .foregroundStyle(Color.Text.subtitle)
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
            
            if (error as? APIError) == .noTournament {
                
                // todo: ...
            }
        }
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
