import SwiftData
import SwiftUI

@MainActor
extension ModelContainer {
    static var preview: ModelContainer {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: RecipeModel.self,ItemModel.self,MealModel.self, configurations: config)
        let recipesRepositoryDB = RecipesPersistenceRepository(modelContext: container.mainContext)
        let itemsRepositoryDB = ItemsPersistenceRepository(modelContext: container.mainContext)
        
        do {
            // First load test recipes
            try recipesRepositoryDB.importAll(RecipesRepositoryTest())
            // First load test items
            let itemsName = ["Apple", "Banana", "Pizza", "Water"]
            for itemName in itemsName {
                try itemsRepositoryDB.insert(itemName)
            }
        } catch {
            print("Error importing recipes: \(error)")
        }
        
        return container
    }
}

extension View {
    func testEnvironment() -> some View {
        let modelContext = ModelContainer.preview.mainContext
        return self.environment(RecipesViewModel(modelContext: modelContext))
    }
}


