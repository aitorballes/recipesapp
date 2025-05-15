import Foundation

protocol RecipesRepositoryProtocol {
    func getRecipes() throws -> [RecipeModel]
    
}

struct RecipesRepository: RecipesRepositoryProtocol {
    func getRecipes() throws -> [RecipeModel] {
        guard let url = Bundle.main.url(forResource: "recipes_formatted", withExtension: "json") else {
            throw URLError(.badURL)
        }
        
        let data = try Data(contentsOf: url)
        guard let responseDTO = try? JSONDecoder().decode(RecipesResponseDTO.self, from: data) else {
            throw URLError(.badServerResponse)
        }
        
        return responseDTO.recipes.map { dto in
            dto.toModel()
        }
    }
}


    

