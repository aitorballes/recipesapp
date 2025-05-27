import Foundation
import SwiftData

@Observable
final class ShoppingListViewModel:  BaseViewModelProtocol {
    private let repository: any ItemsPersistenceRepositoryProtocol
    private let modelContext: ModelContext
    
    var state: ViewState = .loading
    var newItemName: String = ""

    init(modelContext: ModelContext, repository: (any ItemsPersistenceRepositoryProtocol)? = nil) {
        self.modelContext = modelContext
        self.repository = repository ?? ItemsPersistenceRepository(modelContext: modelContext)
        state = .loaded
    }

    func addItem() {
        guard !newItemName.isEmpty else { return }
        do {
            try repository.add(newItemName)
            newItemName = ""

        } catch {
            state = .error(error)
        }
    }

    func deleteItem(_ item: ItemModel) {
        do {
            if item.isErased {               
                try repository.delete(item)
                
            } else {
                item.isErased = true                
            }

        } catch {
            state = .error(error)
        }
    }

    func restoreItem(_ item: ItemModel) {
        item.isErased = false
    }
}
