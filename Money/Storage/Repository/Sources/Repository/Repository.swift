import Foundation

public protocol Storable {
    associatedtype Identifier: Hashable
//    associatedtype StorageObject
    var id: Identifier { get }
//    func convertToStorageObject() -> StorageObject
}

public protocol Repository {
    associatedtype ItemIdentifier
    associatedtype Item: Storable where Item.Identifier == ItemIdentifier
    func add(items: AnySequence<Item>) async throws
    func get(predicate: NSPredicate?, sortDescriptors: [NSSortDescriptor]) async throws -> [Item]
    func delete(predicate: NSPredicate) async throws
}
