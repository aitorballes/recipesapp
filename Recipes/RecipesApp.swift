import SwiftData
import SwiftUI

@main
struct RecipesApp: App {

//        let modelContainer: ModelContainer = {
//            let configuration = ModelConfiguration()
//            return try! ModelContainer(for: [RecipeModel.self, ItemModel.self], configurations: configuration)
//        }()

    var body: some Scene {
        WindowGroup {
            WelcomeView()
        }
        .modelContainer(for: [RecipeModel.self, ItemModel.self]) { result in
            guard case .success(let container) = result else {
                return
            }

            firstRecipesLoad(container)

        }
    }
    
    private func firstRecipesLoad(_ modelContainer:ModelContainer) {
        let repository = RecipesPersistenceRepository(
            modelContext: modelContainer.mainContext)
        guard (try? repository.fetchAll().first?.name == nil) ?? false else {
            return
        }

        do {
            try repository.importAll(RecipesRepository())
        } catch {
            print("Error importing recipes: \(error)")
        }
    }
}
