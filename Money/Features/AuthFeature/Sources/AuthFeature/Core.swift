// 
//  Core.swift (AuthFeature)
//  Money
//
//  Created by Mikhail Dudarev on 27.11.2022.
//

import ComposableArchitecture
import Services
import SwiftUI

// MARK: - Typealiases
public typealias Reducer = ComposableArchitecture.Reducer<State, Action, Environment>
public typealias Store = ComposableArchitecture.Store<State, Action>
public typealias ViewStore = ComposableArchitecture.ViewStore<State, Action>

// MARK: - TCA
public struct State: Equatable {
    var email: String = .empty
    var password: String = .empty
    var isAuthenticated: Bool = false
    
    public init() {}
}

public enum Action {
    case emailDidChange(String)
    case passwordDidChange(String)
    case signIn
    case signUp
    case authenticated
    case failedToAuthenticate
}

public struct Environment {
    let authService: AuthServiceLogic
    
    public init(authService: AuthServiceLogic) {
        self.authService = authService
    }
}

public let reducer = Reducer { state, action, env in
    switch action {
    case .emailDidChange(let newEmail):
        state.email = newEmail
        return .none
    case .passwordDidChange(let newPassword):
        state.password = newPassword
        return .none
    case .signIn:
        return .task { [state] in
            do {
                try await env.authService.login(email: state.email, password: state.password)
                return Action.authenticated
            } catch let error as AuthService.Error {
                print(error)
                return Action.failedToAuthenticate
            }
        }
    case .signUp:
        return .none
    case .authenticated:
        state.isAuthenticated = true
        return .none
    case .failedToAuthenticate:
        // TODO
        return .none
    }
}

// MARK: - Convenience
public extension Store {
    static let live = Store(
        initialState: State(),
        reducer: reducer,
        environment: Environment(authService: AuthService())
    )
    static let preview = Store(
        initialState: State(),
        reducer: reducer,
        environment: Environment(authService: AuthService())
    )
}
