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
            
            Spacer()
            
            Text("Create Tournament")
                .font(Font.system(size: 22, weight: .bold))
                .frame(maxWidth: .infinity, alignment: .leading)
                .foregroundStyle(Color.Text.normal)
                .padding(.bottom, 2)
            
            Text("Choose a title for your tournament")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(Font.system(size: 18, weight: .medium))
                .foregroundStyle(Color.Text.subtitle)
            
            HStack {
                
                Image(systemName: "plus.circle")
                    .font(Font.system(size: 17, weight: .medium))
                    .foregroundStyle(.gray.opacity(0.7))
                    .padding(.leading, 16)
                    .padding(.trailing, 8)
                
                TextField("", text: $title, prompt: Text("Choose a title...").foregroundStyle(.gray.opacity(0.7)))
                    .font(Font.system(size: 17, weight: .medium))
                    .foregroundStyle(Color.Text.normal)
                    .background(.clear)
                    .padding(.trailing, 16)
                    .padding(.vertical, 14)
            }
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 15).fill((Color(UIColor.systemGray6))))
            .padding(.top, 16)
            
            Button("Create", action: createButtonTapped)
                .buttonStyle(MainButtonStyle())
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 64)
                .padding(.top, 16)
            
            Spacer()
        }
        .padding(.all, 16)
    }
    
    private func createButtonTapped() {
        viewModel.createTournament(title: title, resetInterval: .never)
    }
}
