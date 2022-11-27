//
//  Strings.swift
//  AuthFeature
//
//  Created by Mikhail Dudarev on 27.11.2022.
//

import Foundation

enum Strings: String {
    case email
    case password
    case signIn
    case signUp

    var localized: String {
        NSLocalizedString(rawValue, bundle: Bundle.module, comment: .empty)
    }
}
