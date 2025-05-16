import SwiftUI
import SwiftData

@main
struct RecipesApp: App {
    
    let modelContainer: ModelContainer = {
        let configuration = ModelConfiguration()
        return try! ModelContainer(for: RecipeEntity.self, configurations: configuration)
    }()
            
    
    var body: some Scene {
        WindowGroup {
            WelcomeView()
        }
        .modelContainer(modelContainer)
    }
}
