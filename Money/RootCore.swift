//
//  AppCore.swift
//  Money
//
//  Created by Mikhail Dudarev on 05.10.2022.
//

import ComposableArchitecture
import SwiftUI

// MARK: - Typealiases
typealias RootReducer = Reducer<RootState, RootAction, RootEnvironment>
typealias RootStore = Store<RootState, RootAction>
typealias RootViewStore = ViewStore<RootState, RootAction>

// MARK: - Types
enum RootTab: Hashable {
    case accounts
    case transactions
}

// MARK: - TCA
struct RootState: Equatable {
    var selectedTab: RootTab = .transactions
    var accounts = AccountsState()
    var transactions = TransactionsState()
}

enum RootAction {
    case selectTab(RootTab)
    case accountsAction(AccountsAction)
    case transactionsAction(TransactionsAction)
}

struct RootEnvironment {}

let rootReducer = RootReducer { state, action, env in
    switch action {
    case .selectTab(let tab):
        state.selectedTab = tab
        return Effect.none
    case .accountsAction(let accountsAction):
        return Effect.none
    }
}

// MARK: - Convenience
extension RootStore {
    static let live = RootStore.init(initialState: RootState(), reducer: rootReducer, environment: RootEnvironment())
    static let preview = RootStore.init(initialState: RootState(), reducer: rootReducer, environment: RootEnvironment())
}

extension RootViewStore {
    var selectedTab: Binding<RootTab> {
        binding(get: \.selectedTab, send: { .selectTab($0) })
    }
}
