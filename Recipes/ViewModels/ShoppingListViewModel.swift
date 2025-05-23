import Foundation
import SwiftData

@Observable
final class ShoppingListViewModel {
    private let repository: any ItemsPersistenceRepositoryProtocol
    private let modelContext: ModelContext
    var newItemName: String = ""

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        repository = ItemsPersistenceRepository(modelContext: modelContext)
    }

    func addItem() {
        guard !newItemName.isEmpty else { return }
        do {
            try repository.add(newItemName)
            newItemName = ""

        } catch {
            print("Error adding item: \(error.localizedDescription)")
        }
    }

    func deleteItem(_ item: ItemModel) {
        do {
            if item.isErased {               
                try repository.delete(item)
            } else {
                try repository.markAsDeleted(item)
            }

        } catch {
            print("Error deleting item: \(error.localizedDescription)")
        }
    }

    func restoreItem(_ item: ItemModel) {
        do {
            try repository.restore(item)
        } catch {
            print("Error restoring item: \(error.localizedDescription)")
        }
    }
}
