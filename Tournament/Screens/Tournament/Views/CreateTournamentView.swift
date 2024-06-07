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
                .font(Font.system(size: 22, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(Color.Text.normal)
            
            HStack {
                
                Image(systemName: "plus.circle")
                    .font(Font.system(size: 18, weight: .medium))
                    .foregroundStyle(.gray.opacity(0.7))
                    .padding(.leading, 16)
                    .padding(.trailing, 8)
                
                TextField("", text: $title, prompt: Text("Choose a title...").foregroundStyle(.gray.opacity(0.7)))
                    .font(Font.system(size: 18, weight: .medium))
                    .foregroundStyle(.gray)
                    .background(.clear)
                    .padding(.trailing, 16)
                    .padding(.vertical, 12)
            }
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 15).fill(.brown).opacity(0.2))
            
            Spacer()
            
            Button("Create", action: createButtonTapped)
                .buttonStyle(MainButtonStyle())
                .frame(maxWidth: .infinity)
        }
        .padding(.all, 32)
    }
    
    private func createButtonTapped() {
        viewModel.createTournament(title: title, resetInterval: .never)
    }
}
