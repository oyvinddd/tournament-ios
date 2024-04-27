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
        
        VStack(spacing: 4) {
            
            Text("Error!")
                .font(Font.system(size: 32, weight: .bold, design: .rounded))
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(.black)
            
            Text(error.localizedDescription)
                .font(Font.system(size: 20, weight: .medium, design: .rounded))
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(.gray)
        }
        .background(.white)
    }
}
