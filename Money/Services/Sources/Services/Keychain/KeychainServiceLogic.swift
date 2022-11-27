//
//  KeychainServiceLogic.swift
//  Services
//
//  Created by Mikhail Dudarev on 27.11.2022.
//

public protocol KeychainServiceLogic {
    func get<T: Decodable>(for key: KeychainKey) throws -> T?
    func set<T: Encodable>(_ value: T, for key: KeychainKey) throws
    func remove(key: KeychainKey) throws
}
