import Foundation
import SwiftUI
import SwiftData

struct RecipesRepositoryTest: RecipesRepositoryProtocol {
    func getRecipes() throws -> [RecipeModel] {
        guard
            let url = Bundle.main.url(
                forResource: "recipes_test", withExtension: "json")
        else {
            throw URLError(.badURL)
        }

        let data = try Data(contentsOf: url)
        guard
            let responseDTO = try? JSONDecoder().decode(
                RecipesResponseDTO.self, from: data)
        else {
            throw URLError(.badServerResponse)
        }

        return responseDTO.recipes.map { dto in
            dto.toModel()
        }
    }
}

extension ModelContainer {
    static var preview: ModelContainer {
        let config = ModelConfiguration(isStoredInMemoryOnly: true)
        let container = try! ModelContainer(for: RecipeEntity.self, configurations: config)
        return container
    }
}


extension View {
    func testEnvironment() -> some View {
        let modelContext = ModelContainer.preview.mainContext
        let testRepository = RecipesRepositoryTest()
        return self.environment(RecipesViewModel(repository: testRepository, modelContext: modelContext))
    }
}

extension RecipeModel {
    static var testData: RecipeModel {
        .init(
            id: 1,
            name: "Classic Margherita Pizza",
            ingredients: [
                "Pizza dough",
                "Tomato sauce",
                "Fresh mozzarella cheese",
                "Fresh basil leaves",
                "Olive oil",
                "Salt and pepper to taste",
            ],
            instructions: [
                "Preheat the oven to 475°F (245°C).",
                "Roll out the pizza dough and spread tomato sauce evenly.",
                "Top with slices of fresh mozzarella and fresh basil leaves.",
                "Drizzle with olive oil and season with salt and pepper.",
                "Bake in the preheated oven for 12-15 minutes or until the crust is golden brown.",
                "Slice and serve hot.",
            ],
            prepTimeMinutes: 10,
            cookTimeMinutes: 20,
            servings: 4,
            difficulty: "Easy",
            cuisine: "Italian",
            image: URL(string:"https://cdn.dummyjson.com/recipe-images/2.webp")!,
            rating: 4.5,
            mealType: ["Dinner", "Lunch"]
        )
    }

}
