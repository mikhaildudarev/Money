//
//  File.swift
//  
//
//  Created by Mikhail Dudarev on 27.11.2022.
//

import Foundation

public protocol AuthServiceLogic {
    var isAuthenticated: Bool { get }
    func login(email: String, password: String) async throws
    func logout() async throws
}
