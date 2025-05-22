import SwiftData
import SwiftUI

struct MealsView: View {
    @Environment(MealsViewModel.self) private var viewModel: MealsViewModel
    @Query() private var meals: [MealModel]
    @Query() private var recipes: [RecipeModel]

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

                    Picker(
                        "🍽️ Recipe",
                        selection: $viewModelBindable.selectedRecipe
                    ) {
                        Text("Select a recipe")
                            .tag(nil as RecipeModel?)
                        ForEach(recipes) { recipe in
                            Text(recipe.name)
                                .tag(recipe as RecipeModel?)
                        }
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
                            description: Text("There is no meals available. Please try to add some.")
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
                                        Label("Delete",systemImage: "trash.fill")
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
        }
    }
}
