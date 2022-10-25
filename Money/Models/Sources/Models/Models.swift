//
//  Models.swift (Models)
//  Money
//
//  Created by Mikhail Dudarev on 13.10.2022.
//

import Foundation

public struct Account: Equatable {
    public let id: UUID
    public let name: String
    public let balance: Decimal
    
    public init(id: UUID = UUID(), name: String, balance: Decimal) {
        self.id = id
        self.name = name
        self.balance = balance
    }
}
