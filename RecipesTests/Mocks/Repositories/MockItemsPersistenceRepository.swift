import SwiftData
import Foundation
@testable import Recipes

final class MockItemsPersistenceRepository: ItemsPersistenceRepositoryProtocol {
    let modelContext: ModelContext
    
    var addCalled = false
    var shouldThrowOnAdd = false
    var deleteCalled = false
    var shouldThrowOnDelete = false
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func add(_ itemName: String) throws {
        addCalled = true
        if shouldThrowOnAdd {
            throw PersistenceError.insertFailed
        }
    }
    
    func delete(_ item: ItemModel) throws {
        deleteCalled = true
        if shouldThrowOnDelete {
            throw PersistenceError.deleteFailed
        }
    }
}

