//
//  ErrorView.swift
//  Tournament
//
//  Created by Øyvind Hauge on 26/04/2024.
//

import SwiftUI

struct ErrorView: View {
    
    var error: Error
    var action: (() -> Void)?
    
    init(_ error: Error, action: (() -> Void)? = nil) {
        self.error = error
        self.action = action
    }
    
    var body: some View {
        
        VStack {
            
            Spacer()
            
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
                .font(Font.system(size: 20, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .center)
                .multilineTextAlignment(.center)
                .foregroundStyle(Color.Text.normal)
                .padding(.horizontal, 16)
                .padding(.bottom, 2)
            
            Text(error.localizedDescription)
                .font(Font.system(size: 17, weight: .medium))
                .frame(maxWidth: .infinity, alignment: .center)
                .multilineTextAlignment(.center)
                .foregroundStyle(Color.Text.subtitle)
                .padding(.horizontal, 16)
                .padding(.bottom, 16)
            
            if let action = action {
                Button(action: action) {
                    Text("Retry")
                        .frame(maxWidth: .infinity)
                }
                .buttonStyle(SecondaryButtonStyle())
            }
            
            Spacer()
        }
        .padding(.horizontal, 16)
        .background(.white)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}
