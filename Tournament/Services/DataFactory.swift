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
        Player(id: UUID(), username: "ruben", score: 1800),
        Player(id: UUID(), username: "oyvind", score: 1200),
        Player(id: UUID(), username: "ola", score: 1200),
        Player(id: UUID(), username: "rune", score: 1200),
        Player(id: UUID(), username: "ruben", score: 1200),
        Player(id: UUID(), username: "oyvind", score: 1920),
        Player(id: UUID(), username: "ola", score: 1930),
        Player(id: UUID(), username: "rune", score: 910),
        Player(id: UUID(), username: "ruben", score: 800),
        Player(id: UUID(), username: "oyvind", score: 1100),
        Player(id: UUID(), username: "ola", score: 1200),
        Player(id: UUID(), username: "rune", score: 1200),
        Player(id: UUID(), username: "ruben", score: 1200),
        Player(id: UUID(), username: "oyvind", score: 1000),
        Player(id: UUID(), username: "ola", score: 1200),
        Player(id: UUID(), username: "rune", score: 1210)
    ])
    
    static let shared = DataFactory()
}
