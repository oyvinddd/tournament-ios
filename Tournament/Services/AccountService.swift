//
//  AccountService.swift
//  Tournament
//
//  Created by Øyvind Hauge on 29/05/2024.
//

import Foundation
import Combine

protocol AccountServiceInjectable {
    
    var accountService: AccountService { get }
}

extension AccountServiceInjectable {
    
    var accountService: AccountService { LiveServiceFactory.instance.accountService }
}

protocol AccountService {
    
    var account: Account? { get }
    
    var accessToken: String? { get }
    
    var signedIn: PassthroughSubject<Bool, Never> { get }
    
    func set(account: Account)
    
    func signOut()
}

final class LiveAccountService: AccountService {

    static let shared = LiveAccountService()
    
    var account: Account?
    
    var accessToken: String? { account?.accessToken }
    
    var signedIn: PassthroughSubject = PassthroughSubject<Bool, Never>()
    
    init() {
        do {
            let credentials = try CredentialsManager.load()
            account = credentials.account
            account?.accessToken = credentials.accessToken
            signedIn.send(true)
            
            print("Signed in as \(account!.username)! 🤩")
            
        } catch let error {
            print("Error loading credentials: \(error)")
            signedIn.send(false)
        }
    }
    
    func set(account: Account) {
        // sign in
        self.account = account
        signedIn.send(true)
        
        // store credentials locally
        let credentials = Credentials(account, account.accessToken)
        try? CredentialsManager.save(credentials)
    }
    
    func signOut() {
        CredentialsManager.clear()
        signedIn.send(false)
        print("Signed out! bye bye ... 😭")
    }
}

enum CredentialsError: Error {
    case notFound, invalid
}

private struct CredentialsManager {
    
    static func save(_ credentials: Credentials) throws {
        clear()
        
        let data = try JSONEncoder().encode(credentials)
        UserDefaults.standard.set(data, forKey: "credentials")
    }
    
    static func load() throws -> Credentials {
        let decoder = JSONDecoder()
        
        guard let data = UserDefaults.standard.object(forKey: "credentials") as? Data else {
            throw CredentialsError.notFound
        }
        
        return try decoder.decode(Credentials.self, from: data)
    }
    
    static func clear() {
        UserDefaults.standard.removeObject(forKey: "credentials")
    }
}
