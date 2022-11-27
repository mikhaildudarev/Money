//
//  KeychainService.swift
//  Services
//
//  Created by Mikhail Dudarev on 27.11.2022.
//

import Foundation
import KeychainAccess

public final class KeychainService: KeychainServiceLogic {
    public enum Error: Swift.Error {
        case keychainNotInitalized
        case decodingFailed(underlyingError: Swift.Error)
        case encodingFailed(underlyingError: Swift.Error)
        case unknown(underlyingError: Swift.Error)
    }
    
    // MARK: - Properties
    private lazy var keychain: Keychain? = {
        guard let bundleId = Bundle.main.bundleIdentifier else { return nil }
        return Keychain(service: bundleId)
    }()
    
    // MARK: - KeychainServiceLogic
    public func get<T: Decodable>(for key: KeychainKey) throws -> T? {
        guard let keychain else { throw Error.keychainNotInitalized }
        
        let data: Data?
        do {
            data = try keychain.getData(key.rawValue)
        } catch {
            throw Error.unknown(underlyingError: error)
        }
        
        guard let data else { return nil }
        
        let value: T?
        do {
            value = try JSONDecoder().decode(T.self, from: data)
        } catch {
            throw Error.decodingFailed(underlyingError: error)
        }
        
        return value
    }
    
    public func set<T: Encodable>(_ value: T, for key: KeychainKey) throws {
        guard let keychain else { throw Error.keychainNotInitalized }
        
        let data: Data
        do {
            data = try JSONEncoder().encode(value)
        } catch {
            throw Error.encodingFailed(underlyingError: error)
        }
        
        do {
            try keychain.set(data, key: key.rawValue)
        } catch {
            throw Error.unknown(underlyingError: error)
        }
    }
    
    public func remove(key: KeychainKey) throws {
        guard let keychain else { throw Error.keychainNotInitalized }
        do {
            try keychain.remove(key.rawValue)
        } catch {
            throw Error.unknown(underlyingError: error)
        }
    }
}
