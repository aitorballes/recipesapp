import Foundation
import SwiftData

@Observable
final class MealsViewModel: BaseViewModelProtocol {
    private let repository: any MealsPersistenceRepositoryProtocol
    private let modelContext: ModelContext
    
    var state: ViewState = .loading
    var selectedDate = Date()
    var selectedRecipe: RecipeModel? 
    
    init(modelContext: ModelContext, repository: (any MealsPersistenceRepositoryProtocol)? = nil) {
        self.modelContext = modelContext
        
        self.repository = repository ?? MealsPersistenceRepository(modelContext: modelContext)
        state = .loaded
    }
    
    func addMeal(){
        guard let selectedRecipe else { return }
        do {
            try repository.add(selectedDate, selectedRecipe)
            self.selectedRecipe = nil
        
        } catch {
            state = .error(error)
        }
    }
    
    func deleteMeal(_ meal: MealModel) {
        do {
            try repository.delete(meal)
        } catch {
            state = .error(error)
        }
    }

}
