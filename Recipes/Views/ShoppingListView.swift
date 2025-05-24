import SwiftUI
import SwiftData

struct ShoppingListView: View {
    @Environment(ShoppingListViewModel.self) private var viewModel: ShoppingListViewModel
    @Query(sort: [SortDescriptor(\ItemModel.id, order: .reverse)]) private var items: [ItemModel]

    var body: some View {
        @Bindable var viewModelBindable: ShoppingListViewModel = viewModel

        NavigationStack {
            HStack {
                TextField("Add new item", text: $viewModelBindable.newItemName)
                Button {
                    viewModel.addItem()
                } label: {
                    Image(systemName: "plus")
                        .imageScale(.large)
                        .tint(.primary)
                }
            }
            .padding()

            List {
                ForEach(items) { item in
                    Text("\(item.name) \(item.icon)")
                        .strikethrough(item.isErased, color: .secondary)
                        .opacity(item.isErased ? 0.6 : 1)
                        .swipeActions(edge: .trailing) {

                            Button {
                                viewModel.deleteItem(item)
                            } label: {
                                Label("Delete", systemImage: "trash.fill")
                            }
                            .tint(.red)
                        }
                        .swipeActions(edge: .leading) {
                            if item.isErased {
                                Button {
                                    viewModel.restoreItem(item)
                                } label: {
                                    Label("Add", systemImage: "plus.app.fill")
                                }
                                .tint(.blue)
                            }
                        }
                }
            }
            .scrollIndicators(.hidden)
            .listStyle(.plain)
            .navigationTitle("Shopping List")
            .overlay {
                if items.isEmpty {
                    ContentUnavailableView(
                        "No Items", systemImage: "carrot.fill",
                        description: Text(
                            "There is no items available. Please try to add some."
                        ))
                }
                
                if case .loading = viewModel.state {
                    ProgressView()
                        .progressViewStyle(.circular)
                        .padding()
                }
            }
            .alert("Error", isPresented: Binding<Bool>(
                get: { viewModelBindable.showError },
                set: { _ in viewModelBindable.state = .loaded }
              )) {
                
            } message: {
               Text(viewModel.errorMessage)
            } 

        }
    }
}
