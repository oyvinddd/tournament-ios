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
                .font(Font.system(size: 24, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(Color.Text.normal)
                .padding(.bottom, 4)
            
            Text("Please insert code")
                .font(Font.system(size: 18, weight: .medium))
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(Color.Text.subtitle)
                .padding(.bottom, 20)
            
            DigitInputView()
            
            Spacer()
        }
        .padding(.horizontal, 16)
    }
}

#Preview {
    JoinTournamentView(viewModel: JoinTournamentViewModel())
}
