//
//  SecurityService.swift
//  Services
//
//  Created by Mikhail Dudarev on 27.11.2022.
//

import CryptoKit
import Foundation

final class SecurityService: SecurityServiceLogic {
    // MARK: - Properties
    #warning("salt must be configured at least for the release version of the app")
    private static let salt = ""
    
    // MARK: - Internal Methods
    func sha256(fromString string: String, salted: Bool = false) -> String {
        let input = salted ? string.appending(Self.salt) : string
        let data = Data(input.utf8)
        let digest = SHA256.hash(data: data)
        return digest.compactMap({ String(format: "%02x", $0) }).joined()
    }
}
