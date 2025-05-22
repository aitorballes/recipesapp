import SwiftData
import Foundation

protocol MealsPersistenceRepositoryProtocol {
    
    func insert(_ mealDate: Date, _ recipe: RecipeModel) throws
    func delete(_ meal: MealModel) throws
}

struct MealsPersistenceRepository: MealsPersistenceRepositoryProtocol {
    let modelContext: ModelContext
    
    func insert(_ mealDate: Date, _ recipe: RecipeModel) throws  {
        let maxID = try getMaxId()
        let meal = MealModel(id: maxID + 1, date: mealDate, recipe: recipe)
        modelContext.insert(meal)
        try modelContext.save()
    }
    
    func delete(_ meal: MealModel) throws {        
        modelContext.delete(meal)
        try modelContext.save()
    }
    
    private func getMaxId() throws -> Int {
        let fetchDescriptor = FetchDescriptor<MealModel>()
        return try modelContext.fetch(fetchDescriptor).map(\.id).max() ?? 0
    }
}
