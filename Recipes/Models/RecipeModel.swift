import Foundation

struct RecipeModel: Codable, Identifiable, Hashable {
    let id: Int
    let name: String
    let ingredients: [String]
    let instructions: [String]
    let prepTimeMinutes: Int
    let cookTimeMinutes: Int
    let servings: Int
    let difficulty: String
    let cuisine: String
    let image: URL
    let rating: Double
    let mealType: [String]
    
    var isFavorite: Bool = false
    var isSaved: Bool = false
}
