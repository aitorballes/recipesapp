import SwiftData
import Foundation

protocol MealsPersistenceRepositoryProtocol : BasePersistenceRepositoryProtocol where ModelType == MealModel {
    
    func add(_ mealDate: Date, _ recipe: RecipeModel) throws
}

struct MealsPersistenceRepository: MealsPersistenceRepositoryProtocol {
    let modelContext: ModelContext
    
    func add(_ mealDate: Date, _ recipe: RecipeModel) throws  {
        let maxID = try getMaxId()
        let meal = MealModel(id: maxID + 1, date: mealDate, recipe: recipe)
        try insert(meal)
    }
}
