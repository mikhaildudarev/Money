//
//  AuthService.swift
//  Services
//
//  Created by Mikhail Dudarev on 27.11.2022.
//

import Foundation

public final class AuthService: AuthServiceLogic {
    struct State {
        let email: String
    }
    
    public enum Error: Swift.Error {
        case invalidInput(String)
    }
    
    // MARK: - Properties
    public var isAuthenticated: Bool {
        state != nil
    }
    
    private var state: State?
    
    // MARK: - Init/Deinit
    public init() {}
    
    // MARK: - AuthServiceLogic
    public func login(email: String, password: String) async throws {
        guard !email.isEmpty else { throw Error.invalidInput("Email should not be empty") }
        guard !password.isEmpty else { throw Error.invalidInput("Password should not be empty") }
        // TODO
        state = State(email: email)
    }
    
    public func logout() async throws {
        // TODO
        state = nil
    }
}
