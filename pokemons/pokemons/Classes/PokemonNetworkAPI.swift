import Foundation

public enum PokemonApiError: Error {
    
    case incorrectInputFormat
    case urlInit
    case networkError(NetworkError)
}


public class PokemonNetworkAPI: PokemonAPI {

    // MARK: -
    // MARK: Initialization
    
    public init() {}
    
    // MARK: -
    // MARK: Public
    
    public enum Links {
        static let random = "https://pokeapi.co/api/v2/pokemon?limit="
    }
    
    public func pokemons(count: Int, completion: @escaping (Result<NetworkDataNode<[Pokemon]>, PokemonApiError>) -> ()) {
        guard count > 0 else {
            completion(.failure(.incorrectInputFormat))
            return
        }
        guard let url = URL(string: Links.random + String(count)) else {
            completion(.failure(.urlInit))
            return
        }

        NetworkHelper.getData(NetworkDataNode<[Pokemon]>.self, url: url) { result in
            switch result {
            case .success(let node):
                completion(.success(node))
            case .failure(let error):
                completion(.failure(.networkError(error)))
            }
        }
    }
    
    public func abilities(pokemon: Pokemon, completion: @escaping (Result<[PokemonAbility], PokemonApiError>) -> ()) {
        NetworkHelper.getData(PokemonAbilities.self, url: pokemon.url) { result in
            switch result {
            case .success(let node):
                completion(.success(node.abilities))
            case .failure(let error):
                completion(.failure(.networkError(error)))
            }
        }
    }
}
