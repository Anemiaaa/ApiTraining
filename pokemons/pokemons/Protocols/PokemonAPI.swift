import Foundation

public protocol PokemonAPI {
    
    func pokemons(count: Int, completion: @escaping (Result<NetworkDataNode<[Pokemon]>, PokemonApiError>) -> ()) 
    
    func abilities(pokemon: Pokemon, completion: @escaping (Result<[PokemonAbility], PokemonApiError>) -> ())
}
