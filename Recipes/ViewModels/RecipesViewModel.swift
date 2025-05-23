import Foundation
import Observation
import SwiftData    

@Observable
final class RecipesViewModel: BaseViewModelProtocol {
    private let repository: any RecipesPersistenceRepositoryProtocol
    private let modelContext: ModelContext
    private var recipes: [RecipeModel] = []
    
    var state: ViewState = .loading
    var selectedCuisineType: String = "All"
    var searchText = ""
    var showFavorites = false
    var isFilterOpen = false
    
    var cuisineTypes: [String] {
        ["All"] + Array(Set(recipes.map(\.cuisine))).sorted()
    }
    
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
        
        if showFavorites {
            result = result.filter { $0.isFavorite }
        }
        
        return hasMatches
        ? result.filter { $0.cuisine.contains(selectedCuisineType) }
        : result
    }
    
    var savedRecipes: [RecipeModel] {
        recipes.filter { $0.isSaved }
    }

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        
        repository = RecipesPersistenceRepository(modelContext: modelContext)
        getRecipes()      
    }

    func getRecipes() {
        do {
            recipes = try repository.fetchAll()
            state = .loaded
        } catch {
            state = .error(error)
            print("Error: \(error.localizedDescription)")
        }
    }

    func saveRecipe(_ recipe: RecipeModel) {
        do {
            try repository.toggleSaved(recipe)
            
        } catch {
            state = .error(error)
            print("Error saving recipe: \(error.localizedDescription)")
        }
    }
    
    func favRecipe(_ recipe: RecipeModel) {
        do {
            try repository.toggleFavorite(recipe)        
        } catch {
            state = .error(error)
            print("Error saving recipe: \(error.localizedDescription)")
        }
    }
}
