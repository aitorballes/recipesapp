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
            AppLogger.shared.info("Marking item as deleted: \(item.name)")
            item.isErased = true
            try modelContext.save()
            AppLogger.shared.info("Item marked as deleted successfully")
        } catch {
            AppLogger.shared.error("Error marking item as deleted: \(error.localizedDescription)")
            throw .updateFailed
        }
    }

    func restore(_ item: ItemModel) throws(PersistanceError) {
        do {
            AppLogger.shared.info("Restoring item: \(item.name)")
            item.isErased = false
            try modelContext.save()
            AppLogger.shared.info("Item restored successfully")
        } catch {
            AppLogger.shared.error("Error restoring item: \(error.localizedDescription)")
            throw .updateFailed
        }
    }
}
