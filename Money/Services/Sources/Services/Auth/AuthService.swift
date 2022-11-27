//
//  AuthService.swift
//  Services
//
//  Created by Mikhail Dudarev on 27.11.2022.
//

import Foundation

public final class AuthService: AuthServiceLogic {
    struct Credentials: Codable {
        let email: String
        let password: String
    }
    
    public enum Error: Swift.Error {
        case alreadySignedIn
        case invalidInput(String)
        case keychainError(KeychainService.Error)
    }
    
    // MARK: - Properties
    public var isAuthenticated: Bool {
        credentials != nil
    }
    
    private let keychainService: KeychainServiceLogic = KeychainService()
    private let securityService: SecurityServiceLogic = SecurityService()
    
    private var credentials: Credentials? {
        do {
            return try keychainService.get(for: .credentials)
        } catch {
            print(error)
            return nil
        }
    }
    
    // MARK: - Init/Deinit
    public init() {}
    
    // MARK: - AuthServiceLogic
    public func login(email: String, password: String) async throws {
        let credentials: Credentials?
        do {
            credentials = try keychainService.get(for: .credentials)
        } catch let error as KeychainService.Error {
            throw Error.keychainError(error)
        }
        
        guard credentials == nil else { throw Error.alreadySignedIn }
        guard !email.isEmpty else { throw Error.invalidInput("Email should not be empty") }
        guard !password.isEmpty else { throw Error.invalidInput("Password should not be empty") }
        
        let newCredentials = Credentials(
            email: email,
            password: securityService.sha256(fromString: password, salted: true)
        )
        
        do {
            try keychainService.set(newCredentials, for: .credentials)
        } catch let error as KeychainService.Error {
            throw Error.keychainError(error)
        }
    }
    
    public func logout() async throws {
        do {
            try keychainService.remove(key: .credentials)
        } catch let error as KeychainService.Error {
            throw Error.keychainError(error)
        }
    }
}
