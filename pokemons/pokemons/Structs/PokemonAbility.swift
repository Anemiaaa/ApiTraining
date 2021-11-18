import Foundation

public struct PokemonAbility: Codable {
    
    enum CodingKeys: String, CodingKey {
        
        case ability
        case isHidden = "is_hidden"
    }
    
    public let ability: [String: String]
    public let isHidden: Bool
}

public struct PokemonAbilities: Codable {
    
    public let abilities: [PokemonAbility]
}
