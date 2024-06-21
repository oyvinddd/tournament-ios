//
//  HeaderView.swift
//  Tournament
//
//  Created by Øyvind Hauge on 05/06/2024.
//

import SwiftUI

struct HeaderView: View {
    
    @Binding var account: Account?
    @Binding var title: String
    @Binding var playerFilter: String
    @Binding var btBroadcastingState: BroadcastingState
    @Binding var showAccount: Bool
    
    var body: some View {
        
        VStack {
            
            // top part
            HStack {
                Text(title)
                    .font(Font.system(size: 26, weight: .bold))
                    .foregroundStyle(.white)
                
                Spacer()
                
                AccountButtonView(account?.emoji, $btBroadcastingState, $showAccount)
            }
            
            // search field
            HStack {
                
                Image(systemName: "magnifyingglass")
                    .font(Font.system(size: 18, weight: .medium))
                    .foregroundStyle(.white.opacity(0.7))
                    .padding(.leading, 16)
                    .padding(.trailing, 8)
                
                TextField("", text: $playerFilter, prompt: Text("Filter players...").foregroundStyle(.white.opacity(0.7)))
                    .textInputAutocapitalization(.never)
                    .autocorrectionDisabled(true)
                    .keyboardType(.alphabet)
                    .font(Font.system(size: 18, weight: .medium))
                    .foregroundStyle(.white)
                    .background(.clear)
                    .padding(.trailing, 16)
                    .padding(.vertical, 12)
            }
            .frame(maxWidth: .infinity)
            .background(RoundedRectangle(cornerRadius: 15).fill(.white).opacity(0.2))
        }
        .padding(.horizontal, 16)
        .padding(.bottom, 8)
    }
}

#Preview {
    
    @State var account: Account? = Account(id: UUID(), email: "foo@bar.baz", userName: "john_doe", totalMatchesPlayed: 0, totalMatchesWon: 0, createdDate: Date.now, updatedDate: Date.now)
    @State var title = "Foo Tournament"
    @State var filter = ""
    @State var btBroadcastingState = BroadcastingState.enabled
    @State var showAccount = false
    
    return HeaderView(account: $account, title: $title, playerFilter: $filter, btBroadcastingState: $btBroadcastingState, showAccount: $showAccount)
}
