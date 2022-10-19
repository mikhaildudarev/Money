// 
//  Core.swift (NewAccountFeature)
//  Money
//
//  Created by Mikhail Dudarev on 13.10.2022.
//

import ComposableArchitecture
import Models
import SwiftUI

// MARK: - Typealiases
public typealias Reducer = ComposableArchitecture.Reducer<State, Action, Environment>
public typealias Store = ComposableArchitecture.Store<State, Action>
public typealias ViewStore = ComposableArchitecture.ViewStore<State, Action>

// MARK: - TCA
public struct State: Equatable {
    var accountName: String = ""
    var accountBalance: String = ""

    public var account: Account {
        Account(
            name: accountName,
            balance: Decimal(string: accountBalance) ?? .zero
        )
    }
    
    public init() {}
}

public enum Action {
    case closeButtonTapped
    case saveButtonTapped
    case accountNameDidChange(String)
    case accountBalanceDidChange(String)
}

public struct Environment {
    public init() {}
}

public let reducer = Reducer { state, action, env in
    switch action {
    case .closeButtonTapped:
        return .none
    case .saveButtonTapped:
        return .none
    case .accountNameDidChange(let name):
        state.accountName = name
        return .none
    case .accountBalanceDidChange(let balance):
        state.accountBalance = balance
        return .none
    }
}

// MARK: - Convenience
public extension Store {
    static let live = Store(initialState: State(), reducer: reducer,  environment: Environment())
    static let preview = Store(initialState: State(), reducer: reducer, environment: Environment())
}

extension ViewStore {
    var accountNameBinding: Binding<String> {
        binding(get: \.accountName, send: Action.accountNameDidChange)
    }
    var accountBalanceBinding: Binding<String> {
        binding(get: \.accountBalance, send: Action.accountBalanceDidChange)
    }
}
