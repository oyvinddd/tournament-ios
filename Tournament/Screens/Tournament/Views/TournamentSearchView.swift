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
            
            SearchFieldView(query: $query)
            
            Spacer()
            
            switch viewModel.state {
            case .idle:
                
                Image(systemName: "binoculars")
                    .font(Font.system(size: 32))
                    .foregroundStyle(Color.Text.normal)
                    .padding(.bottom, 8)
                    .opacity(0.8)
                
                Text("Search for a tournament by its title")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .multilineTextAlignment(.center)
                    .font(Font.system(size: 18, weight: .semibold))
                    .foregroundStyle(Color.Text.subtitle)
                    .padding(.horizontal, 32)
                
                Spacer()
                    
                
            case .failure(let error):
                
                ErrorView(error)
                
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
            case .noMatchingTournaments:
                
                Image(systemName: "exclamationmark.magnifyingglass")
                    .font(Font.system(size: 32))
                    .foregroundStyle(Color.Text.normal)
                    .padding(.bottom, 8)
                    .opacity(0.8)
                
                Text("No matches for the term \(query)")
                    .frame(maxWidth: .infinity, alignment: .center)
                    .multilineTextAlignment(.center)
                    .font(Font.system(size: 18, weight: .semibold))
                    .foregroundStyle(Color.Text.subtitle)
                    .padding(.horizontal, 32)
                
                Spacer()
            }
        }
        .padding(.horizontal, 16)
    }
}

private struct SearchFieldView: View {
    
    @Binding var query: String
    
    var body: some View {
        
        // search field
        HStack {
            
            Image(systemName: "magnifyingglass")
                .font(Font.system(size: 18, weight: .medium))
                .foregroundStyle(.gray.opacity(0.7))
                .padding(.leading, 16)
                .padding(.trailing, 8)
            
            TextField("", text: $query, prompt: Text("Tournament search...").foregroundStyle(.gray.opacity(0.7)))
                .textInputAutocapitalization(.never)
                .font(Font.system(size: 18, weight: .medium))
                .foregroundStyle(Color.Text.normal)
                .background(.clear)
                .padding(.trailing, 16)
                .padding(.vertical, 12)
        }
        .frame(maxWidth: .infinity)
        .background(RoundedRectangle(cornerRadius: 15).fill((Color(UIColor.systemGray6))))
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

#Preview {
    TournamentSearchView()
}
