import SwiftData
import Foundation

protocol ItemsPersistenceRepositoryProtocol : BasePersistenceRepositoryProtocol where ModelType == ItemModel {
   
    func add(_ itemName: String) throws
}

struct ItemsPersistenceRepository: ItemsPersistenceRepositoryProtocol {
    let modelContext: ModelContext    

    func add(_ itemName: String) throws {
        let maxID = try getMaxId()
        let newItem = ItemModel(id: maxID + 1, name: itemName)
        try insert(newItem)
    }
}
