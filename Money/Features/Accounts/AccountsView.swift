//
//  AccountsView.swift
//  Money
//
//  Created by Mikhail Dudarev on 05.10.2022.
//

import SwiftUI

struct AccountsView: View {
    // MARK: - Properties
    private let store: AccountsStore
    
    // MARK: - Init/Deinit
    init(store: AccountsStore) {
        self.store = store
    }
    
    // MARK: - Layout
    var body: some View {
        Text("Hello, World!")
    }
}

// MARK: - Previews
struct AccountsView_Previews: PreviewProvider {
    static var previews: some View {
        AccountsView(store: AccountsStore.preview)
    }
}
