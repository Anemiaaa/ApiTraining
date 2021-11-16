import Foundation

public protocol PokemonCodable: Codable {
    
    var id: UUID { get }
    var name: String { get }
    var url: URL { get }
    
   // static func random(count: Int, completion: @escaping (Result<[PokemonCodable], randomError>) -> ())
}
