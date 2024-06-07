//
//  TournamentSearchView.swift
//  Tournament
//
//  Created by Øyvind Hauge on 31/05/2024.
//

import SwiftUI

struct TournamentSearchView: View {
    
    @ObservedObject var viewModel = TournamentSearchViewModel()
    @State private var query = ""
    
    var body: some View {
        
        VStack {
            
            switch viewModel.state {
            case .idle:
                Text("Search for a tournament by its title!")
                
            case .failure(let error):
                Text(error.localizedDescription)
            case .success(let tournaments):
                
                List(tournaments, id: \.id) { tournament in

                    SearchResultView(tournament)
                        .listRowInsets(EdgeInsets())
                        .listRowSeparator(.hidden)
                        .padding(.horizontal, 16)
                        .background(.white)
                }
                .listStyle(.plain)
                .listRowSpacing(20)
                .contentMargins(.top, 16)
            }
            
            //Spacer()
            
            TextField("Search for a tournament...", text: $query)
                .frame(maxWidth: .infinity)
                .onChange(of: query) {
                    viewModel.tournamentSearch(query: query)
                }
        }
    }
}

private struct SearchResultView: View {
    
    var tournament: Tournament
    
    init(_ tournament: Tournament) {
        self.tournament = tournament
    }
    
    var body: some View {
        HStack {
            Text(tournament.title)
                .font(Font.system(size: 18, weight: .bold))
                .foregroundStyle(Color.Text.normal)
        }
    }
}
