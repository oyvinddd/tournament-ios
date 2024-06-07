//
//  CreateTournamentView.swift
//  Tournament
//
//  Created by Øyvind Hauge on 26/04/2024.
//

import SwiftUI

struct CreateTournamentView: View {
    
    @ObservedObject var viewModel = CreateTournamentViewModel()
    @State var title = ""
    
    var body: some View {
        
        VStack {
            
            Text("Create Tournament")
                .font(Font.system(size: 28, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .leading)
            
            TextField("Tournament title...", text: $title)
                .font(Font.system(size: 18, weight: .bold))
                .frame(maxWidth: .infinity)
                .backgroundStyle(.gray)
            
            Spacer()
            
            Button("Create", action: createButtonTapped)
                .frame(maxWidth: .infinity)
        }
        .padding(.all, 32)
    }
    
    private func createButtonTapped() {
        viewModel.createTournament(title: title, resetInterval: .never)
    }
}
