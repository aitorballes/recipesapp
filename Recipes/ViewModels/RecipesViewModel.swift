import Foundation
import Observation
import SwiftData

@Observable
final class RecipesViewModel {
    private let repository: RecipesPersistenceRepositoryProtocol
    private let modelContext: ModelContext
    private var recipes: [RecipeModel] = []

    var cuisineTypes: [String] {
        ["All"] + Array(Set(recipes.map(\.cuisine))).sorted()
    }
    var selectedCuisineType: String = "All"

    var searchText = ""

    var filteredRecipes: [RecipeModel] {
        var result = recipes

        if !searchText.isEmpty {
            result = result.filter {
                $0.name.localizedStandardContains(searchText)
            }
        }

        let hasMatches = result.contains {
            $0.cuisine.contains(selectedCuisineType)
        }

        return hasMatches
            ? result.filter { $0.cuisine.contains(selectedCuisineType) }
            : result
    }

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        
        repository = RecipesPersistenceRepository(modelContext: modelContext)
        getRecipes()
    }

    func getRecipes() {
        do {
            recipes = try repository.fetchAll()
        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }

    func saveRecipe(_ recipeId: Int) {
        do {
            try repository.toggleSaved(for: recipeId)
            
            if let updatedRecipe = try repository.fetchRecipe(by: recipeId),
               let index = recipes.firstIndex(where: { $0.id == recipeId }) {
                recipes[index] = updatedRecipe
            }
            
        } catch {
            print("Error saving recipe: \(error.localizedDescription)")
        }
    }
    
    func favRecipe(_ recipeId: Int) {
        do {
            try repository.toggleFavorite(for: recipeId)
            
            if let updatedRecipe = try repository.fetchRecipe(by: recipeId),
               let index = recipes.firstIndex(where: { $0.id == recipeId }) {
                recipes[index] = updatedRecipe  
            }
            
        } catch {
            print("Error saving recipe: \(error.localizedDescription)")
        }
    }
}
