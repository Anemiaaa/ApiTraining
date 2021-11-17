import Foundation

public class PokemonNetworkAPI: PokemonAPI {

    public init() {}
    // MARK: -
    // MARK: Public
    
    public enum links {
        static let random = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=")
    }
    
    public func random<DataType: PokemonCodable>(count: Int, dataType: DataType, completion: @escaping (Result<NetworkDataNode<[DataType]>, randomError>) -> ()) {
        guard count > 0 else {
            completion(.failure(.incorrectInputFormat))
            return
        }
        guard let url = links.random?.appendingPathComponent(String(count)) else {
            completion(.failure(.urlInit))
            return
        }

        NetworkHelper.getData(NetworkDataNode<[DataType]>.self, url: url) {
            completion(.success($0))
        }
    }
    
    public func abilities(pokemon: PokemonCodable, completion: @escaping ([PokemonAbility]) -> ()) {
        NetworkHelper.getData(PokemonAbilities.self, url: pokemon.url) { node in
            completion(node.abilities)
        }
    }
}
