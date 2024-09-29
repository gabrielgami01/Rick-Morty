import Foundation

struct EpisodeListDTO: Codable {
    let results: [EpisodeDTO]
}

struct EpisodeDTO: Codable {
    let id: Int
    let name: String
    let airDate: String
    let episode: String
    
    enum CodingKeys: String, CodingKey {
        case id
        case name
        case airDate = "air_date"
        case episode
    }
    
    private func getSeasonNumber() -> Int? {
        let components = episode.split(separator: "E").first?.dropFirst().split(separator: "S")
        if let seasonString = components?.last {
            return Int(seasonString)
        }
        return nil
    }
    
    private func getEpisodeNumber() -> Int? {
        let components = episode.split(separator: "E")
        if let episodeString = components.last {
            return Int(episodeString)
        }
        return nil
    }
    
    var toEpisode: Episode {
        Episode(id: id,
                name: name,
                airDate: airDate,
                season: getSeasonNumber() ?? 0,
                episode: getEpisodeNumber() ?? 0
        )
    }
}

struct Episode {
    let id: Int
    let name: String
    let airDate: String
    let season: Int
    let episode: Int
}
