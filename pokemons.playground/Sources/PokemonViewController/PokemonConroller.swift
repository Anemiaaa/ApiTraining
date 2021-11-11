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

public class PokemonController {
    
    // MARK: -
    // MARK: Variables
    
    public var pokemons: [Weak<Pokemon>] = []
    
    weak var view: PokemonView?
    
    // MARK: -
    // MARK: Initialization
    
    public init(view: PokemonView) {
        self.view = view
    }
    
    // MARK: -
    // MARK: Public
    
    public func addPokemons(count: Int, completion: @escaping (Result<[Pokemon], randomError>) -> ()) {
        Pokemon.random(count: count) { [weak self] result in
            switch result {
            case .success(let pokemons):
                self?.pokemons = pokemons.map { Weak(object: $0) }
                
                completion(.success(pokemons))
            case .failure(let error):
                var errorMessage: String
                
                switch error {
                case .incorrectInputFormat:
                    errorMessage = "В функцию передан параметр с необрабатываемым знаением"
                case .urlInit:
                    errorMessage = "Ошибка инициализации url"
                    
                    if let view = self?.view {
                        view.display(text: errorMessage)
                    }
                    completion(.failure(error))
                }
            }
        }
    }
    
    public func showPokemonInfo(pokemon: Pokemon) {
        guard let pokemon = self.pokemons.first(where: { $0.object?.id == pokemon.id })?.object else { return }
        
        NetworkHelper.getData(PokemonAbilities.self, url: pokemon.url) { [weak self] abilities in

            self?.view?.display(text: [
                "name: " + pokemon.name,
                "\(abilities.abilities.map { $0 })"
            ].compactMap { $0 })
        }
    }
    
}
