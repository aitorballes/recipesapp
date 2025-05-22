import SwiftData
import Foundation

@Model
final class MealModel {    
    @Attribute(.unique) var id: Int
    var date: Date
    var recipe: RecipeModel
    
    init(id: Int, date: Date, recipe: RecipeModel) {
        self.id = id
        self.date = date
        self.recipe = recipe
    }
}
