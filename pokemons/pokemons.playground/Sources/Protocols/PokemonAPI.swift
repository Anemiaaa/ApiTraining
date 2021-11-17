import Foundation

public protocol PokemonAPI {
    
    func random<DataType: PokemonCodable>(count: Int, dataType: DataType, completion: @escaping (Result<NetworkDataNode<[DataType]>, randomError>) -> ())
    
    func abilities(pokemon: PokemonCodable, completion: @escaping ([PokemonAbility]) -> ())
}
