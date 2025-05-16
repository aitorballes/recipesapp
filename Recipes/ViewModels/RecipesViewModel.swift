import Foundation
import Observation

@Observable
final class RecipesViewModel {
    private let repository: RecipesRepositoryProtocol
    private var recipes: [RecipeModel] = []

    var cuisineTypes: [String] {
       ["All"] + Array(Set(recipes.map(\.cuisine))).sorted()
    }
    var selectedCuisineType: String = "All"
    
    var searchText = ""
    
    var filteredRecipes: [RecipeModel] {
        var result = recipes
        
        if !searchText.isEmpty {
            result = result.filter { $0.name.localizedStandardContains(searchText) }
        }
        
        let hasMatches = result.contains {
            $0.cuisine.contains(selectedCuisineType)
        }        
        
        return hasMatches
            ? result.filter { $0.cuisine.contains(selectedCuisineType) }
            : result
    }

    init(repository: RecipesRepositoryProtocol = RecipesRepository()) {
        self.repository = repository
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
    }
    
    func favRecipe(_ recipeId: Int) {
        guard let index = recipes.firstIndex(where: { $0.id == recipeId })
        else {
            return
        }
        
        recipes[index].isFavorite.toggle()
    }
}
