import UIKit

struct APIClient {
   static let shared = APIClient()
    
    func fetchCharacters(page: Int = 1) async throws -> [Character]  {
        let url = URL(string: "https://rickandmortyapi.com/api/character/?page=\(page)")!
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse else {
            throw NetworkError.nonHTTP
        }
        
        if response.statusCode == 200 {
            do {
                return try JSONDecoder().decode(CharacterListDTO.self, from: data).results.map(\.toCharacter)
            } catch {
                throw NetworkError.json(error)
            }
        } else {
            throw NetworkError.status(response.statusCode)
        }
    }
    
    func searchCharacter(name: String) async throws -> [Character] {
        let url = URL(string: "https://rickandmortyapi.com/api/character/?name=\(name)")!
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse else {
            throw NetworkError.nonHTTP
        }
        
        if response.statusCode == 200 {
            do {
                return try JSONDecoder().decode(CharacterListDTO.self, from: data).results.map(\.toCharacter)
            } catch {
                throw NetworkError.json(error)
            }
        } else {
            throw NetworkError.status(response.statusCode)
        }
    }
    
    func fetchCharacterImage(url: URL?) async throws -> UIImage {
        guard let url else {
            throw NetworkError.dataNotValid
        }
        
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse else {
            throw NetworkError.nonHTTP
        }
        
        if response.statusCode == 200 {
            guard let image = UIImage(data: data) else {
                throw URLError(.badServerResponse)
            }
            return image
        } else {
            throw NetworkError.status(response.statusCode)
        }
    }
    
    func fetchEpisodes(page: Int = 1) async throws -> [Episode]  {
        let url = URL(string: "https://rickandmortyapi.com/api/episode/?page=\(page)")!
        let (data, response) = try await URLSession.shared.data(from: url)
        
        guard let response = response as? HTTPURLResponse else {
            throw NetworkError.nonHTTP
        }
        
        if response.statusCode == 200 {
            do {
                return try JSONDecoder().decode(EpisodeListDTO.self, from: data).results.map(\.toEpisode)
            } catch {
                throw NetworkError.json(error)
            }
        } else {
            throw NetworkError.status(response.statusCode)
        }
    }
}
