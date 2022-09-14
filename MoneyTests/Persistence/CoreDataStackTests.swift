//
//  CoreDataStackTests.swift
//  MoneyTests
//
//  Created by Mikhail Dudarev on 14.09.2022.
//

@testable import Money
import XCTest

final class CoreDataStackTests: MoneyTests {

    var coreDataStack: CoreDataStack!
    
    override func setUpWithError() throws {
        coreDataStack = CoreDataStack(storageType: .inMemory)
    }
    
    // TODO: write tests

}
