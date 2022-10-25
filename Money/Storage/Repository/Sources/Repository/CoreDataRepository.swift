//
//  CoreDataRepository.swift
//  
//  Created by Mikhail Dudarev on 20.10.2022.
//

import Foundation
import CoreData
import CoreDataWrapper
import Models

public protocol CoreDataStorable: Storable {
    associatedtype ManagedObject: NSManagedObject
    static var fetchRequest: NSFetchRequest<ManagedObject> { get }
    @discardableResult func insertToCoreData(context: NSManagedObjectContext) -> NSManagedObject
    init?(fromManagedObject: ManagedObject)
}

extension Account: Storable {
    public typealias Identifier = UUID
//    public typealias StorageObject = CDAccount

//    public func convertToStorageObject() -> CDAccount {
//        guard let cdAccount = insertToCoreData(context: <#T##NSManagedObjectContext#>)
//    }
}

extension Account: CoreDataStorable {
    public static var fetchRequest: NSFetchRequest<CDAccount> {
        CDAccount.fetchRequest()
    }
    
    public init?(fromManagedObject managedObject: CDAccount) {
        guard
            let id = managedObject.id,
            let name = managedObject.name,
            let balance = managedObject.balance
        else { return nil }
        self = Account(
            id: id,
            name: name,
            balance: balance as Decimal
        )
    }
    
    @discardableResult public func insertToCoreData(context: NSManagedObjectContext) -> NSManagedObject {
        let cdAccount = CDAccount(context: context)
        cdAccount.balance = NSDecimalNumber(decimal: balance)
        cdAccount.name = name
        return cdAccount
    }
}

public struct CoreDataRepository<Item: CoreDataStorable>: Repository {
    public typealias ItemIdentifier = Item.Identifier
    public typealias Item = Item
    
    private let context: NSManagedObjectContext
    
    public init(context: NSManagedObjectContext) {
        self.context = context
    }
    
    public func add(items: AnySequence<Item>) async throws {
        items.forEach { $0.insertToCoreData(context: context) }
        try context.save()
    }
    
    public func get(predicate: NSPredicate? = nil, sortDescriptors: [NSSortDescriptor] = []) async throws -> [Item] {
        let managedObjects = try context.fetch(Item.fetchRequest)
        return managedObjects.compactMap { Item(fromManagedObject: $0) }
    }
    
    public func delete(predicate: NSPredicate) async throws {
        
    }
}
