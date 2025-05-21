import Foundation
import SwiftData

protocol RecipesPersistenceRepositoryProtocol {
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
        let fetchDescriptor = FetchDescriptor<RecipeModel>(sortBy: [
            SortDescriptor(\.name, order: .forward)
        ])

        return try modelContext.fetch(fetchDescriptor)
    }
    
    func fetchAllSaved() throws -> [RecipeModel] {
        let fetchDescriptor = FetchDescriptor<RecipeModel>(
            predicate: #Predicate { $0.isSaved == true },
            sortBy: [SortDescriptor(\.name, order: .forward)]
        )

        return try modelContext.fetch(fetchDescriptor)
    }


    func toggleFavorite(_ recipe: RecipeModel) throws {
        try toggleAttribute(for: recipe, keyPath: \.isFavorite)
    }

    func toggleSaved(_ recipe: RecipeModel) throws {
        try toggleAttribute(for: recipe, keyPath: \.isSaved)
    }

    private func toggleAttribute(for recipe: RecipeModel, keyPath: ReferenceWritableKeyPath<RecipeModel, Bool>) throws {        
        recipe[keyPath: keyPath].toggle()
        try modelContext.save()
    }
}
