import SwiftUI

struct RecipesView: View {
    @Environment(RecipesViewModel.self) var viewModel: RecipesViewModel

    var body: some View {
        @Bindable var viewModelBindable: RecipesViewModel = viewModel
        NavigationStack {
            FiltersView(
                filters: viewModel.cuisineTypes,
                selectedFilter: $viewModelBindable.selectedCuisineType)

            List {
                ForEach(viewModel.filteredRecipes) { recipe in
                    NavigationLink(value: recipe) {
                        RecipeRowView(recipe: recipe)
                            .swipeActions(edge: .trailing) {
                                Button {
                                    viewModel.favRecipe(recipe.id)
                                } label: {
                                    Label("Favorite", systemImage: "heart.fill")
                                }
                                .tint(.red)
                                Button {
                                    viewModel.saveRecipe(recipe.id)
                                } label: {
                                    Label("Save", systemImage: "bookmark.fill")
                                }
                                .tint(.blue)
                            }
                    }
                }
            }
            .listStyle(.plain)
            .searchable(
                text: $viewModelBindable.searchText, placement: .automatic,
                prompt: "Search recipes"
            )
            .navigationTitle("Recipes")
            .navigationDestination(for: RecipeModel.self) { recipe in
                RecipeDetailView(recipe: recipe)
            }
        }
    }
}

#Preview {
    RecipesView()
        .testEnvironment()
}
