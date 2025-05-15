import SwiftUI

struct FiltersView: View {
    let filters: [String]
    @Binding var selectedFilter: String

    var body: some View {
        ScrollView(.horizontal, showsIndicators: false) {
            HStack(spacing: 10) {
                ForEach(filters, id: \.self) { filter in
                    ButtonFilterView(text: filter, selectedFilter: $selectedFilter)
                }
            }
            .padding()
        }
    }
}

struct ButtonFilterView: View {
    let text: String
    @Binding var selectedFilter: String

    var isSelected: Bool {
        selectedFilter == text
    }

    var body: some View {
        Button {
            selectedFilter = text
        } label: {
            Text("🍽️ \(text)")
                .foregroundColor(.white)
                .padding(8)
                .background(
                    RoundedRectangle(cornerRadius: 25)
                        .fill(isSelected ? .blue.opacity(0.7) : .gray)
                )
        }
    }
}

#Preview {
    @Previewable @State var selectedFilter: String = "Vegetarian"
    FiltersView(filters: ["Vegetarian", "Vegan", "Gluten Free"], selectedFilter:$selectedFilter)
        
        
}
