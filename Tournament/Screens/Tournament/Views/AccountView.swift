//
//  AccountView.swift
//  Tournament
//
//  Created by Øyvind Hauge on 28/04/2024.
//

import SwiftUI

struct AccountView: View {
    
    @State var showSettingsDialog: Bool = false
    
    var account: Account
    var buttonAction: () -> Void
    
    var body: some View {
        
        VStack {
            
            HStack {
                Spacer()
                
                Button(action: buttonAction) {
                    Image(systemName: "gearshape.fill")
                        .renderingMode(.template)
                        .imageScale(.large)
                        .foregroundStyle(Color.Text.disabled)
                }
                .background(.yellow)
            }
            
            ZStack {
                Text("🤩")
                    .font(Font.system(size: 72))
                    .padding(.all, 8)
            }
            .background(Ellipse().fill(.red))
            .padding(.bottom, 8)
            
            Text("Hello, \(account.username)!")
                .frame(maxWidth: .infinity, alignment: .center)
                .font(Font.system(size: 26, weight: .medium, design: .rounded))
                .foregroundStyle(Color.Text.normal)
        }
        .padding(.horizontal, 16)
        .padding(.top, 16)
    }
}
