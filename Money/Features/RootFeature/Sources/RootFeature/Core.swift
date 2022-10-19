// 
//  Core.swift (RootFeature)
//  Money
//
//  Created by Mikhail Dudarev on 13.10.2022.
//

import AccountsFeature
import ComposableArchitecture
import SwiftUI
import TransactionsFeature

// MARK: - Typealiases
public typealias Reducer = ComposableArchitecture.Reducer<State, Action, Environment>
public typealias Store = ComposableArchitecture.Store<State, Action>
public typealias ViewStore = ComposableArchitecture.ViewStore<State, Action>

// MARK: - TCA
public struct State: Equatable {
    var selectedTab: Tab = .accounts
    var accounts = AccountsFeature.State()
    var transactions = TransactionsFeature.State()
}

public enum Action {
    case didSelectTab(Tab)
    case accountsAction(AccountsFeature.Action)
    case transactionsAction(TransactionsFeature.Action)
}

public struct Environment {}

public let reducer = Reducer.combine(
    accountsReducer,
    rootReducer
)

private let accountsReducer = AccountsFeature.reducer
    .pullback(
        state: \State.accounts,
        action: /Action.accountsAction,
        environment: { (env: Environment) in AccountsFeature.Environment() }
    )

private let rootReducer = Reducer { state, action, env in
    switch action {
    case .didSelectTab(let tab):
        state.selectedTab = tab
        return .none
    case .accountsAction(let accountsAction):
        return .none
    }
}

// MARK: - Convenience
public extension Store {
    static let live = Store(initialState: State(), reducer: reducer,  environment: Environment())
    static let preview = Store(initialState: State(), reducer: reducer, environment: Environment())
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
