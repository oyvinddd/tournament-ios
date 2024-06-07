//
//  Emoji.swift
//  Tournament
//
//  Created by Øyvind Hauge on 07/06/2024.
//

import Foundation

struct Emoji {
    
    private static let availableEmojis = [
        "🤩", "😄", "😆", "😍", "🥳",
        "😃", "🤪", "😙", "🙂", "😉",
        "😊", "🥹", "😂", "🥰", "🥸",
        "😜", "😏", "😡", "🤬", "😳",
        "😱", "🥱", "🤢", "🥴", "😵",
        "🫣", "😭", "🤯", "😎", "😇",
        "😗", "😋", "😖", "😷", "🤕",
        "😐", "🙄", "😬", "🤑", "🤫"
    ]
    
    static func emojiFromId(_ id: UUID) -> String {
        return availableEmojis[Int(id.uuidString.hash.magnitude % 40)]
    }
}
