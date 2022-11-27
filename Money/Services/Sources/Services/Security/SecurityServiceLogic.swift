//
//  File.swift
//  
//
//  Created by Mikhail Dudarev on 27.11.2022.
//

import Foundation

protocol SecurityServiceLogic {
    func sha256(fromString string: String, salted: Bool) -> String
}
