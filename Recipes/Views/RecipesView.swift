import SwiftUI

struct RecipesView: View {
    @Environment(RecipesViewModel.self) var viewModel: RecipesViewModel
    @State private var isFiltersOpen = false

    var body: some View {
        @Bindable var viewModelBindable: RecipesViewModel = viewModel
        NavigationStack {
            if isFiltersOpen {
                FiltersView(
                    filters: viewModel.cuisineTypes,
                    selectedFilter: $viewModelBindable.selectedCuisineType)
            }

            List {
                ForEach(viewModel.filteredRecipes) { recipe in
                    NavigationLink(value: recipe) {
                        RecipeRowView(recipe: recipe)
                            .swipeActions(edge: .trailing) {
                                Button {
                                    viewModel.favRecipe(recipe.id)
                                } label: {
                                    Label(
                                        "Favorite",
                                        systemImage: recipe.isFavorite
                                            ? "heart.slash.fill" : "heart.fill")
                                }
                                .tint(.red)
                                Button {
                                    viewModel.saveRecipe(recipe.id)
                                } label: {
                                    Label(
                                        "Save",
                                        systemImage: recipe.isSaved
                                            ? "bookmark.slash.fill"
                                            : "bookmark.fill")
                                }
                                .tint(.blue)
                            }
                    }
                }
            }
            .scrollIndicators(.hidden)
            .listStyle(.plain)
            .searchable(
                text: $viewModelBindable.searchText, placement: .automatic,
                prompt: "Search recipes"
            )
            .navigationTitle("Recipes")
            .navigationDestination(for: RecipeModel.self) { recipe in
                RecipeDetailView(recipe: recipe)
            }
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        withAnimation {
                            isFiltersOpen.toggle()
                        }
                    } label: {
                        Image(systemName: "slider.vertical.3")
                            .imageScale(.large)
                            .tint(.primary)
                    }
                }
            }
        }
    }
}

#Preview {
    RecipesView()
        .testEnvironment()
}
