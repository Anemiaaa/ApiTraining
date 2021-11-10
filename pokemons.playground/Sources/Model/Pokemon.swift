import Foundation

public struct PokemonInfoNode {
    
    let abilities: [String : Any]
    
}

public class Pokemon: Codable {
    
    // MARK: -
    // MARK: Variables
    
    public let id: UUID
    public let name: String
    public let url: URL
    
    // MARK: -
    // MARK: Initialization
    
    init(name: String, url: URL) {
        self.id = UUID()
        self.name = name
        self.url = url
    }
}


// MARK: -
// MARK: Equatable

extension Pokemon: Equatable {
    
    public static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        lhs.id == rhs.id
    }
}
