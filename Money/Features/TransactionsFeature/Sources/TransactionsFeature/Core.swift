// 
//  Core.swift (TransactionsFeature)
//  Money
//
//  Created by Mikhail Dudarev on 13.10.2022.
//

import ComposableArchitecture
import SwiftUI

// MARK: - Typealiases
public typealias Reducer = ComposableArchitecture.Reducer<State, Action, Environment>
public typealias Store = ComposableArchitecture.Store<State, Action>
public typealias ViewStore = ComposableArchitecture.ViewStore<State, Action>

// MARK: - TCA
public struct State: Equatable {
    public init() {}
}

public enum Action {
    case addTransaction
}

public struct Environment {}

public let reducer = Reducer { state, action, env in
    switch action {
    case .addTransaction:
        return .none
    }
}

// MARK: - Convenience
public extension Store {
    static let live = Store(initialState: State(), reducer: reducer,  environment: Environment())
    static let preview = Store(initialState: State(), reducer: reducer, environment: Environment())
}
