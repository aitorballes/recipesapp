import SwiftData
import SwiftUI

@MainActor
extension ModelContainer {
    static var preview: ModelContainer {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: RecipeModel.self, configurations: config)
        let repository = RecipesPersistenceRepository(modelContext: container.mainContext)
        
        do {
            try repository.importAll(RecipesRepositoryTest())
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

