import SwiftUI

struct RecipeRowView: View {
    let recipe: RecipeModel
    let date: Date?
    
    init(recipe: RecipeModel, date: Date? = nil) {
        self.recipe = recipe
        self.date = date
    }
    
    var body: some View {
        HStack (alignment: .top, spacing: 10) {
            CachedImageView(imageUrl: recipe.image)
            
            VStack (alignment: .leading, spacing: 10) {
                Text(recipe.name)
                    .font(.headline)
                    .fontWeight(.bold)
                
                Text("⏲ \(recipe.cookTimeMinutes) min | 🍽 \(recipe.servings) portions")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
                if let date = date {
                    Text("🗓️ \(date.formatted(.dateTime.day().month().year()))")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                        
                } else {
                    HStack {
                        if recipe.isSaved {
                            Image(systemName: "bookmark.fill")
                                .foregroundStyle(.blue)
                        }
                        
                        if recipe.isFavorite {
                            Image(systemName: "heart.fill")
                                .foregroundStyle(.red)
                        }
                    }
                }
                
                             
            }
        }
    }
}

#Preview {
    List {
        RecipeRowView(recipe: .testData, date: Date())
        RecipeRowView(recipe: .testData)
        RecipeRowView(recipe: .testData, date: Date())
    }
    .listStyle(.plain)
        
}
