//
//  AccountsCore.swift
//  Money
//
//  Created by Mikhail Dudarev on 05.10.2022.
//

import ComposableArchitecture

// MARK: - Typealiases
typealias AccountsStore = Store<AccountsState, AccountsAction>
typealias AccountsReducer = Reducer<AccountsState, AccountsAction, AccountsEnvironment>

// MARK: - TCA
struct AccountsState: Equatable {
    var accounts: [Account] = []
}

enum AccountsAction {}

struct AccountsEnvironment {}

let accountsReducer = AccountsReducer { state, action, env in
    .none
}

// MARK: - Convenience
extension AccountsStore {
    static let live = AccountsStore(
        initialState: AccountsState(),
        reducer: accountsReducer,
        environment: AccountsEnvironment()
    )
    
    static let preview = AccountsStore(
        initialState: AccountsState(),
        reducer: accountsReducer,
        environment: AccountsEnvironment()
    )
}
