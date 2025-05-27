import Foundation
import SwiftData

protocol RecipesPersistenceRepositoryProtocol: BasePersistenceRepositoryProtocol where ModelType == RecipeModel {
    func importAll(_ recipesRepository: RecipesRepositoryProtocol) throws
    func fetchAll() throws -> [RecipeModel]    
    func fetchAllSaved() throws -> [RecipeModel]
}    

struct RecipesPersistenceRepository: RecipesPersistenceRepositoryProtocol {
    let modelContext: ModelContext

    func importAll(_ recipesRepository: RecipesRepositoryProtocol) throws {
        AppLogger.shared.info("Importing recipes to the database")
        let recipes = try recipesRepository.getRecipes()
        recipes.forEach { recipe in
            modelContext.insert(recipe)
        }
        AppLogger.shared.info("Successfully imported \(recipes.count) recipes to the database")
    }

    func fetchAll() throws -> [RecipeModel] {
        AppLogger.shared.info("Fetching all recipes from the database")
        return try fetchAll(nil,[SortDescriptor(\RecipeModel.name, order: .forward)])
    }
    
    func fetchAllSaved() throws -> [RecipeModel] {
        AppLogger.shared.info("Fetching all saved recipes from the database")
        return try fetchAll(#Predicate { $0.isSaved == true },[SortDescriptor(\RecipeModel.name, order: .forward)])
    }
}
