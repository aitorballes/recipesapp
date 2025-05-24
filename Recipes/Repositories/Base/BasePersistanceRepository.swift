import Foundation
import SwiftData

protocol BasePersistenceRepositoryProtocol {
    associatedtype ModelType: PersistentModel where ModelType.ID == Int

    var modelContext: ModelContext { get }

    func insert(_ item: ModelType) throws
    func delete(_ item: ModelType) throws
    func fetchAll(_ predicate: Predicate<ModelType>?, _ sortBy: [SortDescriptor<ModelType>]?) throws -> [ModelType]
    func fetchCount() throws -> Int
    func getMaxId() throws -> Int
}

extension BasePersistenceRepositoryProtocol {

    func insert(_ item: ModelType) throws(PersistanceError) {
        do {
            AppLogger.shared.info("Inserting item:")
            modelContext.insert(item)
            try modelContext.save()
            AppLogger.shared.info("Item inserted successfully")            
        } catch {
            AppLogger.shared.error("Error inserting item: \(error.localizedDescription)")
            throw PersistanceError.insertFailed
        }
    }

    func delete(_ item: ModelType) throws(PersistanceError) {
        do {
            AppLogger.shared.info("Deleting item:")
            modelContext.delete(item)
            try modelContext.save()
            AppLogger.shared.info("Item deleted successfully")
            
        } catch {
            AppLogger.shared.error("Error deleting item: \(error.localizedDescription)")
            throw .deleteFailed
        }
    }
    
    func fetchAll(_ predicate: Predicate<ModelType>? = nil,_ sortBy: [SortDescriptor<ModelType>]? = []) throws(PersistanceError) -> [ModelType] {
        do {
            let descriptor = FetchDescriptor<ModelType>(
                predicate: predicate,
                sortBy: sortBy ?? []
            )
            return try modelContext.fetch(descriptor)
        } catch {
            AppLogger.shared.error("Error fetching items: \(error.localizedDescription)")
            throw .fetchFailed
        }
    }
    
    func fetchCount() throws -> Int {
        do {
            AppLogger.shared.info("Fetching count of items")
            let descriptor = FetchDescriptor<ModelType>()
            
            return try modelContext.fetchCount(descriptor)
        } catch {
            AppLogger.shared.error("Error fetching count: \(error.localizedDescription)")
            throw PersistanceError.fetchFailed
        }
    }


    func getMaxId() throws -> Int {
        
        return try fetchAll()
            .map(\.id)
            .max() ?? 0
    }
}
