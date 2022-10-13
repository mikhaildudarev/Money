// 
//  View.swift (RootFeature)
//  Money
//
//  Created by Mikhail Dudarev on 13.10.2022.
//

import AccountsFeature
import ComposableArchitecture
import SwiftUI
import TransactionsFeature

public struct View: SwiftUI.View {
    // MARK: - Properties
    private let store: Store
    
    // MARK: - Init/Deinit
    public init(store: Store) {
        self.store = store
    }
    
    // MARK: - Layout
    public var body: some SwiftUI.View {
        WithViewStore(store) { viewStore in
            NavigationView {
                TabView(selection: viewStore.selectedTab) {
                    AccountsFeature.View(store: AccountsFeature.Store.live)
                        .tabItem { Text("Accounts") }
                        .tag(Tab.accounts)
                    TransactionsFeature.View(store: store.scope(state: \.transactions, action: Action.transactionsAction))
                        .tabItem { Text("Transactions") }
                        .tag(Tab.transactions)
                }
                .padding()
            }
        }
    }
}

struct View_Previews: PreviewProvider {
    static var previews: some SwiftUI.View {
        View(store: Store.preview)
    }
}
