import Foundation

// MARK: - CharacterModel
struct CharacterModel: Decodable {
    let name, status, species, type: String
    let gender: String
    let location: Location
    let image: String
    var imageURL: URL {
        guard let url = URL(string: image) else {
            return Bundle.main.url(forResource: "noImage", withExtension: "png")!
        }
        return url
    }
}

// MARK: - Location
struct Location: Codable {
    let name: String
}
