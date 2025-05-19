import Foundation
import SwiftData

protocol RecipesPersistenceRepositoryProtocol {

    func importAll(_ recipesRepository: RecipesRepositoryProtocol) throws
    
    func fetchRecipe(by id: Int) throws -> RecipeModel?

    func fetchAll() throws -> [RecipeModel]
    
    func fetchAllSaved() throws -> [RecipeModel]

    func toggleFavorite(for recipeId: Int) throws

    func toggleSaved(for recipeId: Int) throws

}

struct RecipesPersistenceRepository: RecipesPersistenceRepositoryProtocol {
    let modelContext: ModelContext

    func importAll(_ recipesRepository: RecipesRepositoryProtocol) throws {
        let recipes = try recipesRepository.getRecipes()
        recipes.forEach { recipe in
            modelContext.insert(recipe)
        }
    }
    
    func fetchRecipe(by id: Int) throws -> RecipeModel? {
        let fetchDescriptor = FetchDescriptor<RecipeModel>(
            predicate: #Predicate { $0.id == id }
        )

        return try modelContext.fetch(fetchDescriptor).first
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


    func toggleFavorite(for recipeId: Int) throws {
        try toggleAttribute(for: recipeId, keyPath: \.isFavorite)
    }

    func toggleSaved(for recipeId: Int) throws {
        try toggleAttribute(for: recipeId, keyPath: \.isSaved)
    }

    private func toggleAttribute(for recipeId: Int, keyPath: ReferenceWritableKeyPath<RecipeModel, Bool>) throws {
        let fetchDescriptor = FetchDescriptor<RecipeModel>(
            predicate: #Predicate { $0.id == recipeId }
        )

        guard let recipe = try modelContext.fetch(fetchDescriptor).first else {
            throw NSError(domain: "Recipe not found", code: 404, userInfo: nil)
        }

        recipe[keyPath: keyPath].toggle()
        try modelContext.save()
    }
}
