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
    
    public init() {}
}

public enum Action {
    case presentNewAccountForm
    case dismissNewAccountForm
    case newAccountAction(NewAccountFeature.Action)
}

public struct Environment {
    public init() {}
}

public let reducer = Reducer.combine(
    NewAccountFeature.reducer
        .optional()
        .pullback(
            state: \.newAccount,
            action: /Action.newAccountAction,
            environment: { _ in NewAccountFeature.Environment() }
        ),
    Reducer { state, action, env in
        switch action {
        case .presentNewAccountForm:
            state.newAccount = NewAccountFeature.State()
            return .none
        case .dismissNewAccountForm:
            state.newAccount = nil
            return .none
        case .newAccountAction(let newAccountAction):
            switch newAccountAction {
            case .close:
                state.newAccount = nil
                return .none
            case .save:
                if let account = state.newAccount?.account {
                    state.accounts.append(account)
                }
                state.newAccount = nil
                return .none
            case .updateAccountBalance:
                return .none
            case .updateAccountName:
                return .none
            }
            
        }
    }
)

// MARK: - Convenience
public extension Store {
    static let live = Store(initialState: State(), reducer: reducer,  environment: Environment())
    static let preview = Store(initialState: State(), reducer: reducer, environment: Environment())
}
