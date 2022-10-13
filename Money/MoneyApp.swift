//
//  MoneyApp.swift
//  Money
//
//  Created by Mikhail Dudarev on 10.09.2022.
//

import RootFeature
import SwiftUI

@main
struct MoneyApp: App {
    var body: some Scene {
        WindowGroup {
            RootFeature.View(store: RootFeature.Store.live)
        }
    }
}
