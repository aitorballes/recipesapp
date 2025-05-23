import SwiftData
import Foundation

protocol ItemsPersistenceRepositoryProtocol : BasePersistenceRepositoryProtocol where ModelType == ItemModel {
   
    func add(_ itemName: String) throws
    func markAsDeleted(_ item: ItemModel) throws
    func restore(_ item: ItemModel) throws
}

struct ItemsPersistenceRepository: ItemsPersistenceRepositoryProtocol {
    let modelContext: ModelContext    

    func add(_ itemName: String) throws {
        let maxID = try getMaxId()
        let newItem = ItemModel(id: maxID + 1, name: itemName)
        try insert(newItem)
    }
    
    func markAsDeleted(_ item: ItemModel) throws(PersistanceError) {
        do {
            item.isErased = true
            try modelContext.save()
        } catch {
            throw .updateFailed
        }
    }

    func restore(_ item: ItemModel) throws(PersistanceError) {
        do {
            item.isErased = false
            try modelContext.save()
        } catch {
            throw .updateFailed
        }
    }
}
