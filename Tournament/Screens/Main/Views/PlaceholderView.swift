//
//  PlaceholderView.swift
//  Tournament
//
//  Created by Øyvind Hauge on 26/04/2024.
//

import SwiftUI

struct PlaceholderView: View {
    
    var body: some View {
        ZStack {
            Text("Placeholder View")
                .font(Font.system(size: 32, weight: .bold))
                .foregroundStyle(.black)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.clear)
    }
}

#Preview {
    EmptyView()
}
