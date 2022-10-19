// 
//  Core.swift (AccountsFeature)
//  Money
//
//  Created by Mikhail Dudarev on 13.10.2022.
//

import NewAccountFeature
import ComposableArchitecture
import Models
import SwiftUI

// MARK: - Typealiases
public typealias Reducer = ComposableArchitecture.Reducer<State, Action, Environment>
public typealias Store = ComposableArchitecture.Store<State, Action>
public typealias ViewStore = ComposableArchitecture.ViewStore<State, Action>

// MARK: - TCA
public struct State: Equatable {
    var accounts: [Account] = []
    var newAccount: NewAccountFeature.State?
    
    var isNewAccountPresented: Bool {
        newAccount != nil
    }
    
    public init() {}
}

public enum Action {
    case addAccountButtonTapped
    case presentNewAccountSheet
    case dismissNewAccountSheet
    case newAccountSheetAction(NewAccountFeature.Action)
}

public struct Environment {
    public init() {}
}

public let reducer = Reducer.combine(
    newAccountReducer,
    accountsReducer
)

private let newAccountReducer = NewAccountFeature.reducer
    .optional()
    .pullback(
        state: \State.newAccount,
        action: /Action.newAccountSheetAction,
        environment: { (env: Environment) in NewAccountFeature.Environment() }
    )

private let accountsReducer = Reducer { state, action, env in
    switch action {
    case .addAccountButtonTapped:
        return .task {
            return .presentNewAccountSheet
        }
    case .presentNewAccountSheet:
        state.newAccount = NewAccountFeature.State()
        return .none
    case .dismissNewAccountSheet:
        state.newAccount = nil
        return .none
    case .newAccountSheetAction(let newAccountAction):
        switch newAccountAction {
        case .closeButtonTapped:
            state.newAccount = nil
            return .none
        case .saveButtonTapped:
            if let account = state.newAccount?.account {
                state.accounts.append(account)
            }
            state.newAccount = nil
            return .none
        case .accountBalanceDidChange, .accountNameDidChange:
            return .none
        }
    }
}

// MARK: - Convenience
public extension Store {
    static let live = Store(initialState: State(), reducer: reducer,  environment: Environment())
    static let preview = Store(initialState: State(), reducer: reducer, environment: Environment())
}
