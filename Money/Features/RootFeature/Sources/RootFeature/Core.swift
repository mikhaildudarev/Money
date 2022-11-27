// 
//  Core.swift (RootFeature)
//  Money
//
//  Created by Mikhail Dudarev on 13.10.2022.
//

import AccountsFeature
import AuthFeature
import ComposableArchitecture
import Services
import SwiftUI
import TransactionsFeature

// MARK: - Typealiases
public typealias Reducer = ComposableArchitecture.Reducer<State, Action, Environment>
public typealias Store = ComposableArchitecture.Store<State, Action>
public typealias ViewStore = ComposableArchitecture.ViewStore<State, Action>

// MARK: - TCA
public struct State: Equatable {
    var isAuthenticated = false
    var selectedTab: Tab = .accounts
    var auth = AuthFeature.State()
    var accounts = AccountsFeature.State()
    var transactions = TransactionsFeature.State()
}

public enum Action {
    case checkAuthentication
    case didSelectTab(Tab)
    case authAction(AuthFeature.Action)
    case accountsAction(AccountsFeature.Action)
    case transactionsAction(TransactionsFeature.Action)
}

public class Environment {
    let authService: AuthServiceLogic
    let auth: AuthFeature.Environment
    let accounts = AccountsFeature.Environment()
    
    init(authService: AuthServiceLogic) {
        self.authService = authService
        self.auth = AuthFeature.Environment(authService: authService)
    }
}

public let reducer = Reducer.combine(
    authReducer,
    accountsReducer,
    rootReducer
)

private let authReducer = AuthFeature.reducer
    .pullback(
        state: \State.auth,
        action: /Action.authAction,
        environment: { (env: Environment) in
            return env.auth
        }
    )

private let accountsReducer = AccountsFeature.reducer
    .pullback(
        state: \State.accounts,
        action: /Action.accountsAction,
        environment: { (env: Environment) in env.accounts }
    )

private let rootReducer = Reducer { state, action, env in
    switch action {
    case .checkAuthentication:
        state.isAuthenticated = env.authService.isAuthenticated
        return .none
    case .didSelectTab(let tab):
        state.selectedTab = tab
        return .none
    case .accountsAction(let accountsAction):
        return .none
    case let .authAction(authAction):
        switch authAction {
        case .authenticated:
            return .task {
                return .checkAuthentication
            }
        case .signIn, .signUp, .emailDidChange, .passwordDidChange, .failedToAuthenticate:
            return .none
        }
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

extension ViewStore {
    var selectedTab: Binding<Tab> {
        binding(get: \.selectedTab, send: { .didSelectTab($0) })
    }
}

// MARK: - Types
public enum Tab: Hashable {
    case accounts
    case transactions
}
