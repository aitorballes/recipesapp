import SwiftUI
import SwiftData

struct ContentTabView: View {
    @Environment(\.modelContext) private var modelContext
    
    var body: some View {
        
            TabView {
                Tab("Recipes", systemImage: "fork.knife") {
                    RecipesView()
                        .environment(RecipesViewModel(modelContext:modelContext))
                }
                Tab("Saved", systemImage: "bookmark.fill") {

                }
                Tab("Shopping List", systemImage: "cart.fill") {

                }
                Tab("Timer", systemImage: "timer") {
                }
            }
        
    }
}

#Preview {
    ContentTabView()
        .testEnvironment()
}
