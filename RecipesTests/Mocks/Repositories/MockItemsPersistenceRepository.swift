import SwiftData
import Foundation
@testable import Recipes

final class MockItemsPersistenceRepository: ItemsPersistenceRepositoryProtocol {
    let modelContext: ModelContext
    
    var addCalled = false
    var shouldThrowOnAdd = false
    var deleteCalled = false
    var shouldThrowOnDelete = false
    var markAsDeletedCalled = false
    var shouldThrowOnMarkAsDeleted = false
    var restoreCalled = false
    var shouldThrowOnRestore = false
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func add(_ itemName: String) throws {
        addCalled = true
        if shouldThrowOnAdd {
            throw PersistenceError.insertFailed
        }
    }
    
    func markAsDeleted(_ item: ItemModel) throws {
        markAsDeletedCalled = true
        if shouldThrowOnMarkAsDeleted {
            throw PersistenceError.updateFailed
        }
    }
    
    func delete(_ item: ItemModel) throws {
        deleteCalled = true
        if shouldThrowOnDelete {
            throw PersistenceError.deleteFailed
        }
    }
    
    func restore(_ item: ItemModel) throws {
        restoreCalled = true
        if shouldThrowOnRestore {
            throw PersistenceError.updateFailed
        }
    }
}

