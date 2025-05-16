import Foundation
import Observation
import SwiftData

@Observable
final class RecipesViewModel {
    private let repository: RecipesRepositoryProtocol
    private let persistenceRepository: RecipesPersistenceRepositoryProtocol
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

    init(
        repository: RecipesRepositoryProtocol = RecipesRepository(), modelContext: ModelContext
    ) {
        self.repository = repository
        self.modelContext = modelContext
        
        persistenceRepository = RecipesPersistenceRepository(modelContext: modelContext)
        getRecipes()
    }

    func getRecipes() {
        do {
            recipes = try repository.getRecipes()

        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }

    func saveRecipe(_ recipeId: Int) {
        guard let index = recipes.firstIndex(where: { $0.id == recipeId })
        else {
            return
        }

        recipes[index].isSaved.toggle()

        do {
            if recipes[index].isSaved {
                try persistenceRepository.save(recipes[index])
            } else {
                try persistenceRepository.delete(recipes[index])
            }
            
            let savedRecipes = try persistenceRepository.fetchAll()
            
            print("Saved recipes: \(savedRecipes.first?.name ?? "")")
        } catch {
            print("Persistence error: \(error.localizedDescription)")
        }
        
       

    }

    func favRecipe(_ recipeId: Int) {
        guard let index = recipes.firstIndex(where: { $0.id == recipeId })
        else {
            return
        }

        recipes[index].isFavorite.toggle()
    }
}
