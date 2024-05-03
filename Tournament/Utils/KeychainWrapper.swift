//
//  KeychainWrapper.swift
//  Tournament
//
//  Created by Øyvind Hauge on 10/04/2024.
//

import Foundation
import Security

struct KeychainWrapper {
    
    private static let service = "no.m31.tournament"
    
    static func store<T: Codable>(_ object: T, for key: String) throws -> Bool {
        
        let data = try JSONEncoder().encode(object)
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key,
            kSecValueData as String: data
        ]
        
        let status = SecItemAdd(query as CFDictionary, nil)
        return status == errSecSuccess
    }
    
    static func load<T: Codable>(key: String) throws -> T? {
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key,
            kSecMatchLimit as String: kSecMatchLimitOne,
            kSecReturnData as String: true
        ]
        
        var result: AnyObject?
        SecItemCopyMatching(query as CFDictionary, &result)
        
        guard let data = result as? Data else {
            return nil
        }
        
        return try JSONDecoder().decode(T.self, from: data)
    }
    
    static func delete(key: String) -> Bool {
        
        let query: [String: Any] = [
            kSecClass as String: kSecClassGenericPassword,
            kSecAttrService as String: service,
            kSecAttrAccount as String: key,
            kSecReturnData as String: false
        ]
        
        let status = SecItemDelete(query as CFDictionary)
        return status == errSecSuccess
    }
}
