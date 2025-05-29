import SwiftUI

struct RecipeDetailView: View {
    let recipe: RecipeModel
    var body: some View {
        ScrollView {
            VStack(spacing: 10) {
                CachedImageView(
                    imageUrl: recipe.image, size: 200, contentMode: .fill
                )
                .shadow(color: .black.opacity(0.4), radius: 7, y: 7)
                .padding()

                VStack(alignment: .leading, spacing: 10) {
                    Text(recipe.name)
                        .font(.title)
                        .fontWeight(.bold)

                    Text("⭐️ \(recipe.rating.formatted())")
                        .font(.headline)
                        .fontWeight(.bold)

                    Text("🍽️ \(recipe.servings) people")
                        .font(.headline)
                        .fontWeight(.bold)

                    Text("⏲️ Prep: \(recipe.prepTimeMinutes) min")
                        .font(.headline)

                }
                .frame(maxWidth: .infinity, alignment: .leading)

                Divider()

                VStack(alignment: .leading, spacing: 10) {
                    Text("Ingredients")
                        .font(.title3)
                        .fontWeight(.bold)

                    ForEach(recipe.ingredients, id: \.self) { ingredient in
                        HStack(alignment: .top) {
                            Text("•")
                                .font(.headline)
                            
                            Text(ingredient)
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
                
                Divider()
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Instructions")
                        .font(.title3)
                        .fontWeight(.bold)

                    ForEach(recipe.instructions, id: \.self) { ingredient in
                        HStack(alignment: .top) {
                            Text("•")
                                .font(.headline)
                            
                            Text(ingredient)
                        }
                    }
                }
                .frame(maxWidth: .infinity, alignment: .leading)
            }
            .padding(.horizontal)

        }

    }
}

#Preview {
    RecipeDetailView(recipe: .testData)

}
