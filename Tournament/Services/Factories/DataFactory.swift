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
    
    static let shared = DataFactory()
    
    let tournament = Tournament(id: UUID(), adminId: UUID(), title: "Tietoevry Table Tennis", created: Date.now, scoreboard: [])
}
