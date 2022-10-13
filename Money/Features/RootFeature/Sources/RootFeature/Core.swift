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
    case selectTab(Tab)
    case accountsAction(AccountsFeature.Action)
    case transactionsAction(TransactionsFeature.Action)
}

public struct Environment {}

public let reducer = Reducer.combine(
    AccountsFeature.reducer.pullback(
        state: \State.accounts,
        action: /Action.accountsAction,
        environment: { _ in AccountsFeature.Environment() }
    ),
    Reducer { state, action, env in
        switch action {
        case .selectTab(let tab):
            state.selectedTab = tab
            return Effect.none
        case .accountsAction(let accountsAction):
            return Effect.none
        }
    }
)

// MARK: - Convenience
public extension Store {
    static let live = Store(initialState: State(), reducer: reducer,  environment: Environment())
    static let preview = Store(initialState: State(), reducer: reducer, environment: Environment())
}

extension ViewStore {
    var selectedTab: Binding<Tab> {
        binding(get: \.selectedTab, send: { .selectTab($0) })
    }
}

// MARK: - Types
public enum Tab: Hashable {
    case accounts
    case transactions
}
