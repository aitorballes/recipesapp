import SwiftUI

struct SavedRecipesView: View {
    @Environment(RecipesViewModel.self) private var viewModel: RecipesViewModel

    var body: some View {
        @Bindable var viewModelBindable: RecipesViewModel = viewModel
        NavigationStack {
            List {
                ForEach(viewModel.savedRecipes) { recipe in
                    NavigationLink(value: recipe) {
                        RecipeRowView(recipe: recipe)
                            .swipeActions(edge: .trailing) {
                                Button {
                                    viewModel.saveRecipe(recipe.id)
                                } label: {
                                    Label("Unsave",systemImage: "bookmark.slash.fill")
                                }
                                .tint(.blue)
                            }
                    }
                }
            }
            .scrollIndicators(.hidden)
            .listStyle(.plain)
            .navigationTitle("Saved Recipes")
            .navigationDestination(for: RecipeModel.self) { recipe in
                RecipeDetailView(recipe: recipe)
            }
            .overlay {
                if viewModel.hasNoRecipes {
                    ContentUnavailableView(
                        "No Recipes", systemImage: "bookmark.slash.fill",
                        description: Text(
                            "There is no saved recipes available. Please save some from the recipes tab."
                        ))

                }
            }
        }
    }
}

#Preview {
    SavedRecipesView()
}
