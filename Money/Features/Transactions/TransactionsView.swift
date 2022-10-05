//
//  TransactionsView.swift
//  Money
//
//  Created by Mikhail Dudarev on 05.10.2022.
//

import SwiftUI

struct TransactionsView: View {
    // MARK: - Properties
    private let store: TransactionsStore
    
    // MARK: - Init/Deinit
    init(store: TransactionsStore) {
        self.store = store
    }
    
    // MARK: - Layout
    var body: some View {
        Text("Hello, World!")
    }
}

// MARK: - Previews
struct TransactionsView_Previews: PreviewProvider {
    static var previews: some View {
        TransactionsView(store: TransactionsStore.preview)
    }
}
