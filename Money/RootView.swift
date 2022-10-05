//
//  ContentView.swift
//  Money
//
//  Created by Mikhail Dudarev on 10.09.2022.
//

import ComposableArchitecture
import SwiftUI

struct RootView: View {
    // MARK: - Properties
    private let store: RootStore
    
    // MARK: - Init/Deinit
    init(store: RootStore) {
        self.store = store
    }
    
    // MARK: - Layout
    var body: some View {
        WithViewStore(store) { viewStore in
            TabView(selection: viewStore.selectedTab) {
                AccountsView(store: store.scope(state: \.accounts, action: RootAction.accountsAction))
                    .tabItem { Text("Accounts") }
                    .tag(RootTab.accounts)
                TransactionsView(store: store.scope(state: \.transactions, action: RootAction.transactionsAction))
                    .tabItem { Text("Transactions") }
                    .tag(RootTab.transactions)
            }
            .padding()
        }
    }
}

struct RootView_Previews: PreviewProvider {
    static var previews: some View {
        RootView(store: RootStore.preview)
    }
}
