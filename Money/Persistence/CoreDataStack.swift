//
//  CoreDataStack.swift
//  Money
//
//  Created by Mikhail Dudarev on 13.09.2022.
//

import CoreData

final class CoreDataStack {
    enum StorageType {
        case persistent
        case inMemory
    }
    
    // MARK: - Constants
    private enum Constants {
        static let persistentContainerName = "CoreDataModel"
        static let inMemoryUrlPath = "/dev/null"
    }
    
    // MARK: - Properties
    private let container: NSPersistentContainer
    
    // MARK: - Init/Deinit
    init(storageType: StorageType = .persistent) {
        container = Self.buildContainer(storageType: storageType)
    }

    // MARK: - Internal Methods
    func setup() async throws {
        try await withCheckedThrowingContinuation { (continuation: CheckedContinuation<Void, Error>) in
            container.loadPersistentStores { _, error in
                if let error {
                    continuation.resume(throwing: error)
                    return
                }
                continuation.resume()
            }
        }
    }
    
    // MARK: - Private Methods
    private static func buildContainer(storageType: StorageType) -> NSPersistentContainer {
        let container = NSPersistentContainer(name: Constants.persistentContainerName)
        if storageType == .inMemory {
            let description = NSPersistentStoreDescription()
            description.url = URL(fileURLWithPath: Constants.inMemoryUrlPath)
            container.persistentStoreDescriptions = [description]
        }
        return container
    }
}
