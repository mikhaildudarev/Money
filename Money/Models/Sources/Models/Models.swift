//
//  Models.swift (Models)
//  Money
//
//  Created by Mikhail Dudarev on 13.10.2022.
//

import Foundation

public struct Account: Equatable {
    let name: String
    let balance: Decimal
    
    public init(name: String, balance: Decimal) {
        self.name = name
        self.balance = balance
    }
}
