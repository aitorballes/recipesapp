import SwiftData
import Foundation

protocol RecipesPersistenceRepositoryProtocol {
    func save(_ recipe: RecipeModel) throws
    
    func delete(_ recipe: RecipeModel) throws
    
    func fetchAll() throws -> [RecipeEntity]
}

struct RecipesPersistenceRepository: RecipesPersistenceRepositoryProtocol {
    let modelContext: ModelContext
    
    func save(_ recipe: RecipeModel) throws {
        let entity = recipe.toEntity()
        modelContext.insert(entity)
        
        try modelContext.save()
    }
    
    func delete(_ recipe: RecipeModel) throws {
        let fetchDescriptor = FetchDescriptor<RecipeEntity>(predicate: #Predicate { $0.id == recipe.id })
        if let entity = try modelContext.fetch(fetchDescriptor).first {
            modelContext.delete(entity)
            try modelContext.save()
        }
    }
    
    func fetchAll() throws -> [RecipeEntity] {
        let fetchDescriptor = FetchDescriptor<RecipeEntity>()
        return try modelContext.fetch(fetchDescriptor)
    }    
}

