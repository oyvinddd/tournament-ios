//
//  CameraView.swift
//  Tournament
//
//  Created by Øyvind Hauge on 26/04/2024.
//

import SwiftUI

struct CameraView: View {
    
    var body: some View {
        ZStack {
            Text("Camera View")
                .font(Font.system(size: 32, weight: .bold))
                .foregroundStyle(.black)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(.blue)
    }
}
