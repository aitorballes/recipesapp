import SwiftUI

struct ContentTabView: View {
    
    var body: some View {
        
            TabView {
                Tab("Recipes", systemImage: "fork.knife") {
                    RecipesView()                       
                }
                Tab("Saved", systemImage: "bookmark.fill") {

                }
                Tab("Shopping List", systemImage: "cart.fill") {

                }
                Tab("Timer", systemImage: "timer") {
                }
            }
        
    }
}

#Preview {
    ContentTabView()
        .testEnvironment()
}
