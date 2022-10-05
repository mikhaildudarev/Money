//
//  TransactionsCore.swift
//  Money
//
//  Created by Mikhail Dudarev on 05.10.2022.
//

import ComposableArchitecture

// MARK: - Typealiases
typealias TransactionsStore = Store<TransactionsState, TransactionsAction>
typealias TransactionsReducer = Reducer<TransactionsState, TransactionsAction, TransactionsEnvironment>

// MARK: - TCA
struct TransactionsState: Equatable {}

enum TransactionsAction {}

struct TransactionsEnvironment {}

let transactionsReducer = TransactionsReducer { state, action, env in
        .none
}

// MARK: - Convenience
extension TransactionsStore {
    static let live = TransactionsStore(
        initialState: TransactionsState(),
        reducer: transactionsReducer,
        environment: TransactionsEnvironment()
    )
    
    static let preview = TransactionsStore(
        initialState: TransactionsState(),
        reducer: transactionsReducer,
        environment: TransactionsEnvironment()
    )
}
