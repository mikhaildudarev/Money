// 
//  View.swift (AuthFeature)
//  Money
//
//  Created by Mikhail Dudarev on 27.11.2022.
//

import ComposableArchitecture
import Helpers
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
                TextField(
                    Strings.email.localized,
                    text: viewStore.binding(
                        get: { $0.email },
                        send: { .emailDidChange($0) }
                    )
                )
                .textFieldStyle(.roundedBorder)
                TextField(
                    Strings.password.localized,
                    text: viewStore.binding(
                        get: { $0.password },
                        send: { .passwordDidChange($0) }
                    )
                )
                .textFieldStyle(.roundedBorder)
                Button(Strings.signIn.localized) {
                    viewStore.send(.signIn)
                }
            }
            .padding()
        }
    }
}

struct View_Previews: PreviewProvider {
    static var previews: some SwiftUI.View {
        View(store: Store.preview)
    }
}
