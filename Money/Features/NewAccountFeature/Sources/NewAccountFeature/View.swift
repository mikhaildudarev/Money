// 
//  View.swift (NewAccountFeature)
//  Money
//
//  Created by Mikhail Dudarev on 13.10.2022.
//

import ComposableArchitecture
import Helpers
import SwiftUI

public struct View: SwiftUI.View {
    // MARK: - Types
    private enum FocusedElement {
        case accountName
        case accountBalance
    }
    
    // MARK: - Properties
    @FocusState private var focusedElement: FocusedElement?
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
                        .focused($focusedElement, equals: .accountName)
                        .textFieldStyle(.roundedBorder)
                    TextField("Balance", text: viewStore.accountBalanceBinding)
                        .focused($focusedElement, equals: .accountBalance)
                        .textFieldStyle(.roundedBorder)
                        .keyboardType(.decimalPad)
                    Spacer()
                }
                .navigationTitle("Create account")
                .navigationBarTitleDisplayMode(.inline)
                .toolbar {
                    ToolbarItem(placement: .navigationBarLeading) {
                        Button("Save") {
                            focusedElement = nil
                            viewStore.send(.saveButtonTapped)
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("Discard") {
                            focusedElement = nil
                            viewStore.send(.closeButtonTapped)
                        }
                    }
                }
                .padding()
                .dismissingFocusOnTapAround(binding: $focusedElement)
            }
        }
    }
}

struct View_Previews: PreviewProvider {
    static var previews: some SwiftUI.View {
        View(store: Store.preview)
    }
}
