import SwiftUI

struct RecipeRowView: View {
    let recipe: RecipeModel
    
    var body: some View {
        HStack (alignment: .top, spacing: 10) {
            CustomImageView(imageUrl: recipe.image)
            
            VStack (alignment: .leading, spacing: 10) {
                Text(recipe.name)
                    .font(.headline)
                    .fontWeight(.bold)
                
                Text("⏲ \(recipe.cookTimeMinutes) min | 🍽 \(recipe.servings) portions")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
                
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

#Preview {
    List {
        ForEach(0..<3) { _ in
            RecipeRowView(recipe: .testData)
        }
    }
    .listStyle(.plain)
        
}
