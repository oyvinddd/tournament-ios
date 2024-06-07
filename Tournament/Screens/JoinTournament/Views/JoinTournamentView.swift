//
//  JoinTournamentView.swift
//  Tournament
//
//  Created by Øyvind Hauge on 26/04/2024.
//

import SwiftUI

struct JoinTournamentView: View {
    
    @ObservedObject var viewModel = JoinTournamentViewModel()
    
    var body: some View {
        VStack {
            
            Spacer()
            
            Text("Join Tournament")
                .font(Font.system(size: 28, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(.black)
                .padding(.bottom, 2)
            
            Text("Input code to join a given tournament")
                .font(Font.system(size: 18, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(.gray)
                .padding(.bottom, 20)
            
            DigitInputView()
            
            Spacer()
        }
        .padding(.all, 32)
    }
}
