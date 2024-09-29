import Foundation

struct CharacterListDTO: Codable {
    let results: [CharacterDTO]
}

struct CharacterDTO: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let origin: OriginDTO
    let location: LocationDTO
    let image: String
    
    var toCharacter: Character {
        Character(
            id: id,
            name: name,
            status: status,
            species: species,
            gender: gender,
            origin: origin.name,
            location: location.name,
            image: URL(string: image)
        )
    }
}

struct OriginDTO: Codable {
    let name: String
    let url: String
}

struct LocationDTO: Codable {
    let name: String
    let url: String
}

struct Character: Codable {
    let id: Int
    let name: String
    let status: String
    let species: String
    let gender: String
    let origin: String
    let location: String
    let image: URL?
}
