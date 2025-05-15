import Foundation

struct RecipesResponseDTO: Codable {
    let recipes: [RecipeDTO]
    let total: Int
    let skip: Int
    let limit: Int
}

struct RecipeDTO: Codable, Identifiable {
    let id: Int
    let name: String
    let ingredients: [String]
    let instructions: [String]
    let prepTimeMinutes: Int
    let cookTimeMinutes: Int
    let servings: Int
    let difficulty: String
    let cuisine: String
    let caloriesPerServing: Int
    let tags: [String]
    let userId: Int
    let image: URL
    let rating: Double
    let reviewCount: Int
    let mealType: [String]
}

extension RecipeDTO {
    func toModel() -> RecipeModel {
        return .init(
            id: self.id,
            name: self.name,
            ingredients: self.ingredients,
            instructions: self.instructions,
            prepTimeMinutes: self.prepTimeMinutes,
            cookTimeMinutes: self.cookTimeMinutes,
            servings: self.servings,
            difficulty: self.difficulty,
            cuisine: self.cuisine,
            image: self.image,
            rating: self.rating,
            mealType: self.mealType
        )
    }
}


