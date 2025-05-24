import Foundation
import SwiftData

@Observable
final class MealsViewModel: BaseViewModelProtocol {
    private let repository: any MealsPersistenceRepositoryProtocol
    private let modelContext: ModelContext
    
    var state: ViewState = .loading
    var selectedDate = Date()
    var selectedRecipe: RecipeModel? 
    
    init(modelContext: ModelContext){
        self.modelContext = modelContext
        
        repository = MealsPersistenceRepository(modelContext: modelContext)
        state = .loaded
    }
    
    func addMeal(){
        guard let selectedRecipe else { return }
        do {
            try repository.add(selectedDate, selectedRecipe)
            self.selectedRecipe = nil
        
        } catch {
            state = .error(error)
            print("Error adding meal: \(error.localizedDescription)")
        }
    }
    
    func deleteMeal(_ meal: MealModel) {
        do {
            try repository.delete(meal)
        } catch {
            state = .error(error)
            print("Error deleting meal: \(error.localizedDescription)")
        }
    }

}
