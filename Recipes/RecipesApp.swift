import SwiftData
import SwiftUI

@main
struct RecipesApp: App {

//        let modelContainer: ModelContainer = {
//            let configuration = ModelConfiguration()
//            return try! ModelContainer(for: [RecipeModel.self, ItemModel.self], configurations: configuration)
//        }()
    let hasCompletedWelcome = UserDefaults.standard.bool(forKey: AppStorageKeys.hasCompletedWelcome)
    var body: some Scene {
        WindowGroup {
            if hasCompletedWelcome {
                SplashScreenView()
            } else{
                WelcomeView()
            }
            
        }
        .modelContainer(for: [RecipeModel.self, ItemModel.self, MealModel.self]) { result in
            guard case .success(let container) = result else {
                return
            }

            firstRecipesLoad(container)

        }
    }
    
    private func firstRecipesLoad(_ modelContainer:ModelContainer) {
        let repository = RecipesPersistenceRepository(
            modelContext: modelContainer.mainContext)
        guard (try? repository.fetchCount() == 0) ?? false else {
            return
        }

        do {
            try repository.importAll(RecipesRepository())
        } catch {
            AppLogger.shared.error("Error importing recipes: \(error.localizedDescription)")
        }
    }
}
