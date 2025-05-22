import Foundation
import SwiftData

@Observable
final class MealsViewModel {
    private let repository: MealsPersistenceRepositoryProtocol
    private let modelContext: ModelContext
    
    var selectedDate = Date()
    var selectedRecipe: RecipeModel? 
    
    init(modelContext: ModelContext){
        self.modelContext = modelContext
        
        repository = MealsPersistenceRepository(modelContext: modelContext)
    }
    
    func addMeal(){
        guard let selectedRecipe else { return }
        do {
            try repository.insert(selectedDate, selectedRecipe)
            self.selectedRecipe = nil
        
        } catch {
            print("Error adding meal: \(error.localizedDescription)")
        }
    }
    
    func deleteMeal(_ meal: MealModel) {
        do {
            try repository.delete(meal)
        } catch {
            print("Error deleting meal: \(error.localizedDescription)")
        }
    }

}
