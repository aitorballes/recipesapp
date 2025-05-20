import SwiftData
import Foundation

protocol ItemsPersistenceRepositoryProtocol {
    func fetchAll() throws -> [ItemModel]
    func insert(_ itemName: String) throws -> ItemModel
    func delete(_ item: ItemModel) throws
    func markAsDeleted(_ item: ItemModel) throws
    func restore(_ item: ItemModel) throws
}

struct ItemsPersistenceRepository: ItemsPersistenceRepositoryProtocol {
    let modelContext: ModelContext

    func fetchAll() throws -> [ItemModel] {
        let fetchDescriptor = FetchDescriptor<ItemModel>(sortBy: [
            SortDescriptor(\.id, order: .forward)
        ])
        return try modelContext.fetch(fetchDescriptor)
    }

    func insert(_ itemName: String) throws -> ItemModel {
        let allItems = try fetchAll()
        let maxID = allItems.map(\.id).max() ?? 0
        let newItem = ItemModel(id: maxID + 1, name: itemName)
        modelContext.insert(newItem)
        try modelContext.save()
        return newItem
    }

    func delete(_ item: ItemModel) throws {        
        
        modelContext.delete(item)
        try modelContext.save()
    }
    
    func markAsDeleted(_ item: ItemModel) throws {
        
        item.isErased = true
        try modelContext.save()
    }

    func restore(_ item: ItemModel) throws {
        
        item.isErased = false
        try modelContext.save()
    }
}
