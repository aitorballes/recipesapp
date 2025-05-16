import SwiftData
import Foundation


@Model
final class RecipeEntity {
    @Attribute(.unique) var id: Int
    var name: String
    var prepTimeMinutes: Int
    var cuisine: String
    var difficulty: String
    var image: URL
    var rating: Double
    
    init(id: Int, name: String, prepTimeMinutes: Int, cuisine: String, difficulty: String, image: URL, rating: Double) {
        self.id = id
        self.name = name
        self.prepTimeMinutes = prepTimeMinutes
        self.cuisine = cuisine
        self.difficulty = difficulty
        self.image = image
        self.rating = rating
    }
}
