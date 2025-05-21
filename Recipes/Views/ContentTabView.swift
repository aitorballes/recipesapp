import SwiftData
import SwiftUI

struct ContentTabView: View {
    @Environment(\.modelContext) private var modelContext

    var body: some View {

        TabView {
            Tab("Recipes", systemImage: "fork.knife") {
                RecipesView()
                    .environment(RecipesViewModel(modelContext: modelContext))
            }
            Tab("Saved", systemImage: "bookmark.fill") {
                SavedRecipesView()
                    .environment(RecipesViewModel(modelContext: modelContext))
            }
            Tab("Shopping List", systemImage: "cart.fill") {
                ShoppingListView()
                    .environment(
                        ShoppingListViewModel(modelContext: modelContext))
            }
            Tab("Timer", systemImage: "timer") {
                TimerView()
                    .environment(TimerViewModel())
            }
        }
    }
}

#Preview {
    ContentTabView()
        .modelContainer(.preview)
}
