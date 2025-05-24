import Foundation

protocol RecipesRepositoryProtocol {
    func getRecipes() throws -> [RecipeModel]
    
}

struct RecipesRepository: RecipesRepositoryProtocol {
    func getRecipes() throws -> [RecipeModel] {
        AppLogger.shared.info("Fetching recipes from local JSON file")
        guard let url = Bundle.main.url(forResource: "recipes_formatted", withExtension: "json") else {
            throw URLError(.badURL)
        }
        
        let data = try Data(contentsOf: url)
        guard let responseDTO = try? JSONDecoder().decode(RecipesResponseDTO.self, from: data) else {
            throw URLError(.badServerResponse)
        }
        
        AppLogger.shared.info("Successfully fetched recipes from local JSON file (\(responseDTO.recipes.count) recipes found)")
        return responseDTO.recipes.map { dto in
            dto.toModel()
        }
    }
}


    

