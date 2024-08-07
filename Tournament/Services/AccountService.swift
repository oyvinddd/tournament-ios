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
    
    var joinedTournament: PassthroughSubject<UUID, Never> { get }
    
    func registerPushToken(_ tokenData: Data) async throws
    
    func set(account: Account, accessToken: String)
    
    func set(tournamentId: UUID)
    
    func signOut()
}

// MARK: - Live account service

final class LiveAccountService: AccountService, RequestFactoryInjectable, NetworkManagerInjectable {

    static let shared = LiveAccountService()
    
    var account: Account?
    
    var accessToken: String?
    
    var signedIn: PassthroughSubject = PassthroughSubject<Bool, Never>()
    
    var joinedTournament: PassthroughSubject = PassthroughSubject<UUID, Never>()
    
    init() {
        do {
            let credentials = try CredentialsManager.load()
            account = credentials.account
            accessToken = credentials.token
            signedIn.send(true)
            printAccountDetails(credentials)
            
        } catch let error {
            print("Error loading credentials: \(error)")
            signedIn.send(false)
        }
    }
    
    func registerPushToken(_ tokenData: Data) async throws {
        guard let pushToken = String(data: tokenData, encoding: .utf8) else {
            throw APIError.invalidPushToken
        }
        let request = requestFactory.registerPushTokenRequest(pushToken)
        try await networkManager.execute(request: request)
    }
    
    func set(account: Account, accessToken: String) {
        // sign in
        self.account = account
        signedIn.send(true)
        
        // store credentials locally
        try? CredentialsManager.save(Credentials(account, accessToken))
    }
    
    func set(tournamentId: UUID) {
        //account?.tournamentId = tournamentId
        
        guard let account = account, let token = accessToken else {
            return
        }
        
        let credentials = Credentials(account, token)
        try? CredentialsManager.save(credentials)
        
        joinedTournament.send(tournamentId)
        
        print("✨ Updated tournament successfully!")
    }
    
    func signOut() {
        CredentialsManager.clear()
        signedIn.send(false)
        print("💥 Signing out! bye bye ... 😭")
    }
    
    private func printAccountDetails(_ creds: Credentials) {
        let userName = creds.account.userName
        let userId = creds.account.id
        let tournament = creds.account.tournamentAccounts?.first
        let tournamentId = tournament?.id.uuidString ?? "None"
        
        print("✨ Signed in as \(userName) / \(creds.account.email) (\(userId))")
        print("✨ Tournament: \(tournamentId)")
        print("✨ Token: \(creds.token)")
    }
}

// MARK: - Local credentials manager

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
