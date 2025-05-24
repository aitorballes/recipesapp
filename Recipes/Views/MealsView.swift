import SwiftData
import SwiftUI

struct MealsView: View {
    @Environment(MealsViewModel.self) private var viewModel: MealsViewModel
    @Query() private var meals: [MealModel]
    @Query() private var recipes: [RecipeModel]

    @State private var showRecipeSheet = false

    var body: some View {
        @Bindable var viewModelBindable: MealsViewModel = viewModel
        NavigationStack {
            Form {
                Section {
                    DatePicker(
                        "🗓️ Date",
                        selection: $viewModelBindable.selectedDate,
                        displayedComponents: .date
                    )

                    HStack {
                        Text("🍽️ Recipe")
                        Spacer()
                        Button {
                            showRecipeSheet = true
                        } label: {
                            if let recipe = viewModel.selectedRecipe {
                                Text(recipe.name)
                                    .foregroundColor(.primary)
                            } else {
                                Text("Select a recipe")
                                    .foregroundColor(.secondary)
                            }
                            Image(systemName: "chevron.up.chevron.down")
                                .foregroundColor(.secondary)

                        }
                        .buttonStyle(.plain)
                    }

                    Button("Add to plan") {
                        viewModel.addMeal()
                    }
                    .disabled(viewModel.selectedRecipe == nil)

                } header: {
                    Text("Plan a Meal")
                }

                Section {

                    if meals.isEmpty {
                        ContentUnavailableView(
                            "No Meals",
                            systemImage: "calendar",
                            description: Text(
                                "There is no meals available. Please try to add some."
                            )
                        )
                    } else {

                        ForEach(meals) { meal in
                            NavigationLink(value: meal.recipe) {
                                RecipeRowView(
                                    recipe: meal.recipe,
                                    date: meal.date
                                )
                                .swipeActions(edge: .trailing) {
                                    Button(role: .destructive) {
                                        viewModel.deleteMeal(meal)
                                    } label: {
                                        Label(
                                            "Delete",
                                            systemImage: "trash.fill"
                                        )
                                    }
                                }
                            }
                        }
                    }
                } header: {
                    Text("Your weekly plan")
                }
            }
            .navigationTitle("Meals Planner")
            .navigationDestination(for: RecipeModel.self) { recipe in
                RecipeDetailView(recipe: recipe)
            }
            .overlay {
                if case .loading = viewModel.state {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .padding()
                }
            }
            .sheet(isPresented: $showRecipeSheet) {
                List {
                    Button {
                        viewModel.selectedRecipe = nil
                        showRecipeSheet = false
                    } label: {
                        Text("Select a recipe")
                            .foregroundColor(.secondary)
                    }

                    ForEach(recipes) { recipe in
                        Button {
                            viewModel.selectedRecipe = recipe
                            showRecipeSheet = false
                        } label: {
                            HStack {
                                Text(recipe.name)
                                if viewModel.selectedRecipe == recipe {
                                    Spacer()
                                    Image(systemName: "checkmark")
                                        .foregroundColor(.accentColor)
                                }
                            }
                        }
                    }
                }
                .scrollIndicators(.hidden)
                .listStyle(.plain)
                .buttonStyle(.plain)
                .presentationDetents([.medium, .large])
            }
        }
    }
}
