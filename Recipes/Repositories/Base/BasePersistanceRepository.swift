import Foundation
import SwiftData

protocol BasePersistenceRepositoryProtocol {
    associatedtype ModelType: PersistentModel where ModelType.ID == Int

    var modelContext: ModelContext { get }

    func insert(_ item: ModelType) throws
    func delete(_ item: ModelType) throws
    func fetchAll(_ predicate: Predicate<ModelType>?, _ sortBy: [SortDescriptor<ModelType>]?) throws -> [ModelType]
    func getMaxId() throws -> Int
}

extension BasePersistenceRepositoryProtocol {

    func insert(_ item: ModelType) throws(PersistanceError) {
        do {
            modelContext.insert(item)
            try modelContext.save()
            
        } catch {
            throw PersistanceError.insertFailed
        }
    }

    func delete(_ item: ModelType) throws(PersistanceError) {
        do {
            modelContext.delete(item)
            try modelContext.save()
            
        } catch {
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
            throw .fetchFailed
        }
    }


    func getMaxId() throws -> Int {
        
        return try fetchAll()
            .map(\.id)
            .max() ?? 0
    }
}
