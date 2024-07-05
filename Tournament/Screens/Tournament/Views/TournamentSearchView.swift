//
//  TournamentSearchView.swift
//  Tournament
//
//  Created by Øyvind Hauge on 31/05/2024.
//

import SwiftUI

private enum IdleState {
    case idle, newTournament
}

struct TournamentSearchView: View {
    
    @ObservedObject var viewModel = TournamentSearchViewModel()
    @State private var idleState: IdleState = .idle
    @State private var query = ""
    
    var body: some View {
        
        VStack {
            
            if idleState == .idle {
                
                SearchFieldView(query: $query)
                
                Spacer()
            }
            
            switch viewModel.state {
            case .idle:
                
                if idleState == .idle {
                    
                    SearchIdleView(idleState: $idleState)
                
                } else {
                
                    CreateTournamentView()
                }
                
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

// MARK: - Search field view

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
                .autocorrectionDisabled(true)
                .keyboardType(.alphabet)
                .font(Font.system(size: 18, weight: .medium))
                .foregroundStyle(Color.Text.normal)
                .background(.clear)
                .padding(.trailing, 16)
                .padding(.vertical, 12)
        }
        .frame(maxWidth: .infinity)
        .background(RoundedRectangle(cornerRadius: 15).fill((Color(UIColor.systemGray6))))
        .padding(.top, 16)
    }
}

// MARK: - Search result view

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

// MARK: - Search idle view

private struct SearchIdleView: View {
    
    @Binding var idleState: IdleState
    
    var body: some View {
        
        Image(systemName: "binoculars")
            .font(Font.system(size: 32))
            .foregroundStyle(Color.Text.normal)
            .padding(.bottom, 8)
            .opacity(0.8)
        
        Text("Search for a tournament or create a new one by tapping the button below")
            .frame(maxWidth: .infinity, alignment: .center)
            .multilineTextAlignment(.center)
            .font(Font.system(size: 18, weight: .semibold))
            .foregroundStyle(Color.Text.subtitle)
            .padding(.horizontal, 32)
        
        Spacer()
        
        Button(action: newTournamentButtonTapped) {
            HStack {
                Image(systemName: "plus.circle")
                
                Text("New Tournament")
                    .font(Font.system(size: 18, weight: .bold))
            }
        }
        .buttonStyle(MainButtonStyle())
    }
    
    private func newTournamentButtonTapped() {
        idleState = .newTournament
    }
}

// MARK: - Create tournament view

private struct CreateTournamentView: View {
    
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

#Preview {
    TournamentSearchView()
}
