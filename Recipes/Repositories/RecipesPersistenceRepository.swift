import Foundation
import SwiftData

protocol RecipesPersistenceRepositoryProtocol: BasePersistenceRepositoryProtocol where ModelType == RecipeModel {
    func importAll(_ recipesRepository: RecipesRepositoryProtocol) throws
    func fetchAll() throws -> [RecipeModel]
    func fetchAllSaved() throws -> [RecipeModel]
    func toggleFavorite(_ recipe: RecipeModel) throws
    func toggleSaved(_ recipe: RecipeModel) throws
}    

struct RecipesPersistenceRepository: RecipesPersistenceRepositoryProtocol {
    let modelContext: ModelContext

    func importAll(_ recipesRepository: RecipesRepositoryProtocol) throws {
        let recipes = try recipesRepository.getRecipes()
        recipes.forEach { recipe in
            modelContext.insert(recipe)
        }
    }

    func fetchAll() throws -> [RecipeModel] {
        return try fetchAll(nil,[SortDescriptor(\RecipeModel.name, order: .forward)])
    }
    
    func fetchAllSaved() throws -> [RecipeModel] {
        return try fetchAll(#Predicate { $0.isSaved == true },[SortDescriptor(\RecipeModel.name, order: .forward)])
    }

    func toggleFavorite(_ recipe: RecipeModel) throws(PersistanceError) {
        try toggleAttribute(for: recipe, keyPath: \.isFavorite)
    }

    func toggleSaved(_ recipe: RecipeModel) throws(PersistanceError) {
        try toggleAttribute(for: recipe, keyPath: \.isSaved)
    }

    private func toggleAttribute(for recipe: RecipeModel, keyPath: ReferenceWritableKeyPath<RecipeModel, Bool>) throws(PersistanceError) {
        do {
            recipe[keyPath: keyPath].toggle()
            
            try modelContext.save()
        } catch {
            throw .updateFailed
        }
        
    }
}
