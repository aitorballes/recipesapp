import SwiftUI

@main
struct RecipesApp: App {
    @State private var viewModel = RecipesViewModel()
    
    var body: some Scene {
        WindowGroup {
            WelcomeView()
                .environment(viewModel)
        }
    }
}
