// 
//  View.swift (AccountsFeature)
//  Money
//
//  Created by Mikhail Dudarev on 13.10.2022.
//

import ComposableArchitecture
import NewAccountFeature
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
            VStack {
                HStack {
                    Spacer()
                    Button("+") {
                        viewStore.send(.addAccountButtonTapped)
                    }
                }
                Spacer()
            }
            .sheet(
                isPresented: viewStore.binding(
                    get: \.isNewAccountPresented,
                    send: { $0 ? .presentNewAccountSheet : .dismissNewAccountSheet }
                )) {
                    IfLetStore(store.scope(state: \.newAccount, action: Action.newAccountSheetAction)) {
                        NewAccountFeature.View(store: $0)
                    }
                }
        }
    }
}

struct View_Previews: PreviewProvider {
    static var previews: some SwiftUI.View {
        View(store: Store.preview)
    }
}
