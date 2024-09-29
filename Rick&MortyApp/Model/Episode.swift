import Foundation

struct EpisodeListDTO: Codable {
    let results: [EpisodeDTO]
}

struct EpisodeDTO: Codable {
    let id: Int
    let name: String
    let airDate: String
    let episode: String
    let characters: [String]
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case airDate = "air_date"
        case episode
        case characters
    }
    
    private func getSeasonNumber() -> Int? {
        let components = episode.split(separator: "E").first?.dropFirst().split(separator: "S")
        if let seasonString = components?.last {
            return Int(seasonString)
        }
        return nil
    }
    
    var toEpisode: Episode {
        Episode(id: id,
                name: name,
                aireDate: airDate,
                season: getSeasonNumber() ?? 0
        )
    }
}

struct Episode {
    let id: Int
    let name: String
    let aireDate: String
    let season: Int
}
