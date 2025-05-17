import SwiftData
import Foundation

extension String {
    var toArray: [String] {
        self.isEmpty ? [] : self.components(separatedBy: ",")
    }
}

extension Array where Element == String {
    var toSerializedString: String {
        self.joined(separator: ",")
    }
}

@Model
final class RecipeModel: Identifiable, Hashable {
    
    @Attribute(.unique) var id: Int
    var name: String
    var ingredientsString: String
    var instructionsString: String
    var prepTimeMinutes: Int
    var cookTimeMinutes: Int
    var servings: Int
    var difficulty: String
    var cuisine: String
    var image: URL
    var rating: Double
    var mealTypeString: String
    var isFavorite: Bool
    var isSaved: Bool
    
    // MARK: - Computed properties
    
    var ingredients: [String] {
        get { ingredientsString.toArray }
        set { ingredientsString = newValue.toSerializedString }
    }
    
    var instructions: [String] {
        get { instructionsString.toArray }
        set { instructionsString = newValue.toSerializedString }
    }
    
    var mealType: [String] {
        get { mealTypeString.toArray }
        set { mealTypeString = newValue.toSerializedString }
    }
    
    // MARK: - Init
    
    init(id: Int,
         name: String,
         ingredients: [String],
         instructions: [String],
         prepTimeMinutes: Int,
         cookTimeMinutes: Int,
         servings: Int,
         difficulty: String,
         cuisine: String,
         image: URL,
         rating: Double,
         mealType: [String],
         isFavorite: Bool = false,
         isSaved: Bool = false) {
        
        self.id = id
        self.name = name
        self.ingredientsString = ingredients.toSerializedString
        self.instructionsString = instructions.toSerializedString
        self.prepTimeMinutes = prepTimeMinutes
        self.cookTimeMinutes = cookTimeMinutes
        self.servings = servings
        self.difficulty = difficulty
        self.cuisine = cuisine
        self.image = image
        self.rating = rating
        self.mealTypeString = mealType.toSerializedString
        self.isFavorite = isFavorite
        self.isSaved = isSaved
    }
}
