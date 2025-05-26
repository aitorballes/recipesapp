import Testing
import SwiftData
@testable import Recipes

@Suite
struct MealsViewModelTests {
    let modelContext = try! makeMockModelContext()
    
    @Test("[addMeal] Adding a meal updates the state and clears the selected recipe")
    func testAddMealSuccess() {
        let mockRepo = MockMealsPersistenceRepository(modelContext: modelContext)
        let viewModel = MealsViewModel(modelContext: modelContext, repository: mockRepo)
        let recipe = RecipeModel.testData
        
        viewModel.selectedRecipe = recipe
        
        viewModel.addMeal()
        
        #expect(mockRepo.addCalled)
        #expect(viewModel.selectedRecipe == nil)
        #expect(viewModel.state == .loaded)
    }
        
    
    @Test("[addMeal] Fails to add a meal if the repository throws an error")
    func testAddMealFailure() {
        let mockRepo = MockMealsPersistenceRepository(modelContext: modelContext)
        mockRepo.shouldThrowOnAdd = true
        
        let viewModel = MealsViewModel(modelContext: modelContext, repository: mockRepo)
        viewModel.selectedRecipe = RecipeModel.testData
        viewModel.addMeal()
        
        #expect(mockRepo.addCalled)
        #expect(viewModel.selectedRecipe != nil)
        #expect(viewModel.state == .error(PersistenceError.insertFailed))
    }
    
    @Test("[addMeal] Does nothing if no recipe is selected")
    func testAddMealNoRecipe() {
        let mockRepo = MockMealsPersistenceRepository(modelContext: modelContext)
        let viewModel = MealsViewModel(modelContext: modelContext, repository: mockRepo)
        
        viewModel.addMeal()
        
        #expect(mockRepo.addCalled == false)
        #expect(viewModel.state == .loaded)
        #expect(viewModel.selectedRecipe == nil)
    }
    
    @Test("[deleteMeal] Deleting a meal updates the state correctly")
    func testDeleteMealSuccess() {
        let mockRepo = MockMealsPersistenceRepository(modelContext: modelContext)
        let viewModel = MealsViewModel(modelContext: modelContext, repository: mockRepo)
        let meal = MealModel.testData
        
        viewModel.deleteMeal(meal)
        
        #expect(mockRepo.deleteCalled)
        #expect(viewModel.state == .loaded)
    }
    
    @Test("[deleteMeal] Fails to delete a meal if the repository throws an error")
    func testDeleteMealFailure() {
        let mockRepo = MockMealsPersistenceRepository(modelContext: modelContext)
        mockRepo.shouldThrowOnDelete = true
        
        let viewModel = MealsViewModel(modelContext: modelContext, repository: mockRepo)
        let meal = MealModel.testData
        
        viewModel.deleteMeal(meal)
        
        #expect(mockRepo.deleteCalled)
        #expect(viewModel.state == .error(PersistenceError.deleteFailed))
    }
}
