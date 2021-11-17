import Foundation

public protocol PokemonCodable: Codable {
    
    var id: UUID { get }
    var name: String { get }
    var url: URL { get }
}
