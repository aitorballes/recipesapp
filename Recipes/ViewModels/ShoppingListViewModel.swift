import Foundation
import SwiftData

@Observable
final class ShoppingListViewModel {
    private let repository: ItemsPersistenceRepositoryProtocol
    private let modelContext: ModelContext
    var items: [ItemModel] = []
    var newItemName: String = ""
    var hasNoItems = false

    var sortedItems: [ItemModel] {
        let activeItems = items.filter { !$0.isDeleted }
        let deletedItems = items.filter { $0.isDeleted }
        let result = activeItems + deletedItems
        hasNoItems = result.isEmpty
        return result
    }

    init(modelContext: ModelContext) {
        self.modelContext = modelContext
        repository = ItemsPersistenceRepository(modelContext: modelContext)
        getItems()
    }

    func getItems() {
        do {
            items = try repository.fetchAll()

        } catch {
            print("Error: \(error.localizedDescription)")
        }
    }

    func addItem() {
        guard !newItemName.isEmpty else { return }
        do {
            let item = try repository.insert(newItemName)
            items.append(item)
            newItemName = ""

        } catch {
            print("Error adding item: \(error.localizedDescription)")
        }
    }

    func deleteItem(_ item: ItemModel) {
        do {
            if item.isErased {
                guard let index = items.firstIndex(of: item) else { return }
                try repository.delete(item)
                items.remove(at: index)
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
