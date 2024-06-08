//
//  TournamentDetailsView.swift
//  Tournament
//
//  Created by Øyvind Hauge on 06/06/2024.
//

import SwiftUI

struct TournamentDetailsView: View {
    
    @State private var showDeleteAlert = false
    
    var body: some View {
        
        VStack {
            
            Text("Tietoevry Bordtennis")
                .frame(maxWidth: .infinity, alignment: .leading)
                .font(Font.system(size: 24, weight: .bold))
                .foregroundStyle(Color.Text.normal)
                .padding(.bottom, 4)
            
            HStack {
                Text("The code is")
                    .font(Font.system(size: 18, weight: .medium))
                    .foregroundStyle(Color.Text.subtitle)
                
                Text("8d7s6x")
                    .font(Font.system(size: 18, weight: .medium))
                    .padding(.horizontal, 4)
                    .padding(.vertical, 2)
                    .background(RoundedRectangle(cornerRadius: 6).fill(Color.Text.subtitle))
                Spacer()
            }
            
            Divider()
            
            Spacer()
            
            Button("Delete tournament", action: deleteButtonTapped)
                .font(Font.system(size: 18, weight: .medium))
                .frame(maxWidth: .infinity)
                .foregroundStyle(.red)
                .padding(.bottom, 16)
        }
        .padding(.horizontal, 16)
        .alert(isPresented: $showDeleteAlert) {
            Alert(
                title: Text("Delete tournament"),
                message: Text("Are you sure you want to delete the tournament?"),
                primaryButton: .destructive(Text("Yes"), action: confirmDeleteTapped),
                secondaryButton: .cancel()
            )
        }
    }
    
    private func deleteButtonTapped() {
        showDeleteAlert.toggle()
    }
    
    private func confirmDeleteTapped() {
    }
}

#Preview {
    TournamentDetailsView()
}
