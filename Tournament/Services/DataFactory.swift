//
//  DataFactory.swift
//  Tournament
//
//  Created by Øyvind Hauge on 26/04/2024.
//

import Foundation

protocol DataFactoryInjectable {
    var dataFactory: DataFactory { get }
}

extension DataFactoryInjectable {
    var dataFactory: DataFactory { DataFactory.shared }
}

final class DataFactory {
    
    let tournament = Tournament(id: UUID(), adminId: UUID(), title: "Tietoevry Table Tennis", created: Date.now, scoreboard: [
        Player(id: UUID(), username: "ruben", score: 1200),
        Player(id: UUID(), username: "oyvind", score: 1200),
        Player(id: UUID(), username: "ola", score: 1200),
        Player(id: UUID(), username: "rune", score: 1200),
        Player(id: UUID(), username: "ruben", score: 1200),
        Player(id: UUID(), username: "oyvind", score: 1200),
        Player(id: UUID(), username: "ola", score: 1200),
        Player(id: UUID(), username: "rune", score: 1200),
        Player(id: UUID(), username: "ruben", score: 1200),
        Player(id: UUID(), username: "oyvind", score: 1200),
        Player(id: UUID(), username: "ola", score: 1200),
        Player(id: UUID(), username: "rune", score: 1200),
        Player(id: UUID(), username: "ruben", score: 1200),
        Player(id: UUID(), username: "oyvind", score: 1200),
        Player(id: UUID(), username: "ola", score: 1200),
        Player(id: UUID(), username: "rune", score: 1200)
    ])
    
    static let shared = DataFactory()
}
