//
//  RequestFactory.swift
//  Tournament
//
//  Created by Øyvind Hauge on 10/04/2024.
//

import Foundation

protocol RequestFactoryInjectable {
    
    var requestFactory: RequestFactory { get }
}

extension RequestFactoryInjectable {
    
    var requestFactory: RequestFactory { RequestFactory(AppConfig.apiBaseUrl) }
}

final class RequestFactory: AccountServiceInjectable {
    
    var apiBaseUrl: URL!
    
    var signInUrl: URL { apiBaseUrl.appendingPathComponent("accounts/login") }
    
    var registerUrl: URL { apiBaseUrl.appendingPathComponent("accounts") }
    
    var tournamentsUrl: URL { apiBaseUrl.appendingPathComponent("tournaments") }
    
    var accountTournament: URL { apiBaseUrl.appendingPathComponent("tournaments/active") }
    
    var searchUrl: URL { tournamentsUrl.appendingPathComponent("search") }
    
    var joinUrl: URL { tournamentsUrl.appendingPathComponent("join") }
    
    var leaveUrl: URL { tournamentsUrl.appendingPathComponent("leave") }
    
    var matcesUrl: URL { apiBaseUrl.appendingPathComponent("matches") }
    
    var accountsUrl: URL { apiBaseUrl.appendingPathComponent("accounts") }
    
    var googleAuthUrl: URL { apiBaseUrl.appendingPathComponent("auth").appendingPathComponent("google") }
    
    var appleAuthUrl: URL { apiBaseUrl.appendingPathComponent("auth").appendingPathComponent("apple") }
    
    var pushTokensUrl: URL { apiBaseUrl.appendingPathComponent("push-tokens") }
    
    init(_ apiBaseUrl: String, addApiAndVersionPath: Bool = false) {
        self.apiBaseUrl = URL(string: apiBaseUrl + (addApiAndVersionPath ? "/api/v1" : ""))!
    }
    
    // MARK: - Account requests
    
    func basicSignInRequest(emailOrUsername: String, password: String) -> URLRequest {
        return RequestBuilder(.post, url: signInUrl)
            .set(value: "application/json", for: "Content-Type")
            .set(body: SignInRequest(emailOrUsername, password))
            .build()
    }
    
    func register(email: String, username: String, password: String) -> URLRequest {
        return RequestBuilder(.post, url: registerUrl)
            .set(value: "application/json", for: "Content-Type")
            .set(body: RegisterRequest(email, username, password))
            .build()
    }
    
    func googleSignInRequest() -> URLRequest {
        return RequestBuilder(.get, url: googleAuthUrl)
            .build()
    }
    
    func createAccountRequest() -> URLRequest {
        return RequestBuilder(.post, url: accountsUrl).build()
    }
    
    func deleteAccountRequest() -> URLRequest {
        return RequestBuilder(.delete, url: accountsUrl)
            .set(token: accountService.accessToken)
            .build()
    }
    
    // MARK: - Tournament requests
    
    func createTournamentRequest(_ title: String, resetInterval: ResetInterval = .never) -> URLRequest {
        return RequestBuilder(.post, url: tournamentsUrl)
            .set(value: "application/json", for: "Content-Type")
            .set(token: accountService.accessToken)
            .set(body: TournamentRequest(title, resetInterval))
            .build()
    }
    
    func tournamentSearchRequest(query: String) -> URLRequest {
        return RequestBuilder(.get, url: searchUrl.appendingPathComponent(query))
            .set(value: "application/json", for: "Content-Type")
            .set(token: accountService.accessToken)
            .build()
    }
    
    func createTournamentRequest(title: String) -> URLRequest {
        return RequestBuilder(.post, url: tournamentsUrl)
            .set(value: "application/json", for: "Content-Type")
            .set(token: accountService.accessToken)
            .set(body: TournamentRequest(title, .monthly))
            .build()
    }
    
    func getTournamentRequest() -> URLRequest {
        return RequestBuilder(.get, url: accountTournament)
            .set(token: accountService.accessToken)
            .build()
    }
    
    func joinTournamentRequest(tournamentId: UUID, code: String) -> URLRequest {
        return RequestBuilder(.put, url: joinUrl.appendingPathComponent(tournamentId.uuidString))
            .set(value: "application/json", for: "Content-Type")
            .set(token: accountService.accessToken)
            .set(body: JoinRequest(code))
            .build()
    }
    
    func leaveTournamentRequest() -> URLRequest {
        return RequestBuilder(.put, url: leaveUrl)
            .set(token: accountService.accessToken)
            .build()
    }
    
    func registerWinRequest(opponentId: UUID) -> URLRequest {
        return RequestBuilder(.post, url: matcesUrl)
            .set(value: "application/json", for: "Content-Type")
            .set(token: accountService.accessToken)
            .set(body: MatchRequest(opponentId))
            .build()
    }
    
    // MARK: - Push tokens
    
    func registerPushTokenRequest(_ token: String) -> URLRequest {
        return RequestBuilder(.post, url: pushTokensUrl)
            .set(value: "application/json", for: "Content-Type")
            .set(token: accountService.accessToken)
            .set(body: PushTokenRequest(token))
            .build()
    }
}

// MARK: - Request Builder

enum HTTPMethod: String {
    case get, post, put, patch, head, delete
}

final class RequestBuilder {
    
    let method: HTTPMethod
    var url: URL
    var headers: [String: String] = [:]
    var param: String?
    var body: Data?
    
    init(_ method: HTTPMethod, url: URL, useDefaultHeaders: Bool = true) {
        self.method = method
        self.url = url
        if useDefaultHeaders {
            headers = defaultHeaders()
        }
    }
    
    @discardableResult
    func set(value: String, for header: String) -> Self {
        headers[header] = value
        return self
    }
    
    @discardableResult
    func set(param: String) -> Self {
        self.param = param
        return self
    }
    
    @discardableResult
    func set(body: Encodable) -> Self {
        self.body = try? JSONEncoder().encode(body)
        return self
    }
    
    @discardableResult
    func set(token: String?) -> Self {
        if let token = token {
            headers["Authorization"] = "Bearer \(token)"
        }
        return self
    }
    
    func build() -> URLRequest {
        if let param = param {
            url.append(path: param, directoryHint: .inferFromPath)
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = method.rawValue
        
        // add http headers to the request
        for (key, value) in headers {
            request.addValue(value, forHTTPHeaderField: key)
        }
        
        // add our data to http body of the request
        request.httpBody = body
        
        return request
    }
    
    private func defaultHeaders() -> [String: String] {
        return [:
            //"X-App-Version": "app_version_here",
            //"X-Device-Type": "device_version_here"
            // "Content-Type": "application/json"
        ]
    }
}
