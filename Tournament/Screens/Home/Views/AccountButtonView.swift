//
//  AccountButtonView.swift
//  Tournament
//
//  Created by Øyvind Hauge on 13/06/2024.
//

import SwiftUI

struct AccountButtonView: View {
    
    var emoji: String?
    @Binding var btBroadcastingState: BroadcastingState
    @Binding var showAccount: Bool
    
    init(_ emoji: String?, _ btBroadcastingState: Binding<BroadcastingState>, _ showAccount: Binding<Bool>) {
        self.emoji = emoji
        self._btBroadcastingState = btBroadcastingState
        self._showAccount = showAccount
    }
    
    var body: some View {
        // account button
        Button(action: accountButtonTapped) {
            ZStack {
                
                Text(emoji ?? "🫠")
                    .font(Font.system(size: 22))
                    .padding(.all, 6)
                
                
                HStack {
                    Spacer()
                    
                    VStack {
                        Spacer()
                        Circle()
                            .fill(colorFromState($btBroadcastingState))
                            .frame(width: 14, height: 14)
                    }
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity)
            }
            .background(RoundedRectangle(cornerRadius: 10).fill(.blue))
            .frame(width: 40, height: 40)
        }
    }
    
    private func accountButtonTapped() {
        UIImpactFeedbackGenerator(style: .light).impactOccurred()
        showAccount.toggle()
    }
    
    private func colorFromState(_ broadcastingState: Binding<BroadcastingState>) -> Color {
        switch broadcastingState.wrappedValue {
        case .enabled: return .green
        default: return .red
        }
    }
}

#Preview {
    @State var emoji: String? = "🥴"
    @State var btBroadcastingState: BroadcastingState = .disabled
    @State var showAccount: Bool = false
    
    return AccountButtonView(emoji, $btBroadcastingState, $showAccount)
}
