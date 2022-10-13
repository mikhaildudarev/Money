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
    var accountBalance: Decimal = .zero

    public var account: Account {
        Account(name: accountName, balance: accountBalance)
    }

    var accountBalanceString: String {
        "\(accountBalance)"
    }
    
    public init() {}
}

public enum Action {
    case close
    case save
    case updateAccountName(String)
    case updateAccountBalance(String)
}

public struct Environment {
    public init() {}
}

public let reducer = Reducer { state, action, env in
    switch action {
    case .close:
        return .none
    case .save:
        return .none
    case .updateAccountName(let name):
        state.accountName = name
        return .none
    case .updateAccountBalance(let balance):
        state.accountBalance = Decimal(string: balance) ?? .zero
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
        binding(get: \.accountName, send: Action.updateAccountName)
    }
    var accountBalanceBinding: Binding<String> {
        binding(get: \.accountBalanceString, send: Action.updateAccountBalance)
    }
}
