import SwiftData
import Foundation
@testable import Recipes

final class MockMealsPersistenceRepository: MealsPersistenceRepositoryProtocol {
    var modelContext: ModelContext
    
    var addCalled = false
    var shouldThrowOnAdd = false
    var deleteCalled = false
    var shouldThrowOnDelete = false
    
    init(modelContext: ModelContext) {
        self.modelContext = modelContext
    }
    
    func add(_ mealDate: Date, _ recipe: RecipeModel) throws {
        addCalled = true
        if shouldThrowOnAdd {
            throw PersistenceError.insertFailed
        }
    }
    
    func delete(_ item: MealModel) throws {
        deleteCalled = true
        if shouldThrowOnDelete {
            throw PersistenceError.deleteFailed
        }
    }
}
