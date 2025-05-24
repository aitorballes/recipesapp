import SwiftData
@testable import Recipes

func makeMockModelContext() throws -> ModelContext {
    let config = ModelConfiguration(isStoredInMemoryOnly: true)
    let container = try ModelContainer(for: MealModel.self, RecipeModel.self, ItemModel.self, configurations: config)
    return ModelContext(container)
}
