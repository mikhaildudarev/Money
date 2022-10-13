// 
//  View.swift (NewAccountFeature)
//  Money
//
//  Created by Mikhail Dudarev on 13.10.2022.
//

import ComposableArchitecture
import SwiftUI

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
                VStack {
                    TextField("Name", text: viewStore.accountNameBinding)
                        .textFieldStyle(.roundedBorder)
                    TextField("Balance", text: viewStore.accountBalanceBinding)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.decimalPad)
                    Spacer()
                }
                .navigationTitle("Create account")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Save", action: { viewStore.send(.save) })
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Discard", action: { viewStore.send(.close) })
                    }

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
