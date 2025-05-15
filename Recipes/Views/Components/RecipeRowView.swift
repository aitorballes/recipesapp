import SwiftUI

struct RecipeRowView: View {
    let recipe: RecipeModel
    
    var body: some View {
        HStack (alignment: .top){
            CustomImageView(imageUrl: recipe.image)
            
            VStack (alignment: .leading) {
                Text(recipe.name)
                    .font(.headline)
                    .fontWeight(.bold)
                
                Text("⏲ \(recipe.cookTimeMinutes) min | 🍽 \(recipe.servings) portions")
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
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
