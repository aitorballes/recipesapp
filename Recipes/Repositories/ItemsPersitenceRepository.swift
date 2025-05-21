import SwiftData
import Foundation

protocol ItemsPersistenceRepositoryProtocol {
   
    func insert(_ itemName: String) throws
    func delete(_ item: ItemModel) throws
    func markAsDeleted(_ item: ItemModel) throws
    func restore(_ item: ItemModel) throws
}

struct ItemsPersistenceRepository: ItemsPersistenceRepositoryProtocol {
    let modelContext: ModelContext    

    func insert(_ itemName: String) throws  {
        let maxID = try getMaxId()
        let newItem = ItemModel(id: maxID + 1, name: itemName)
        modelContext.insert(newItem)
        try modelContext.save()
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
    
    private func getMaxId() throws -> Int {
        let fetchDescriptor = FetchDescriptor<ItemModel>()
        return try modelContext.fetch(fetchDescriptor).map(\.id).max() ?? 0
    }
}
