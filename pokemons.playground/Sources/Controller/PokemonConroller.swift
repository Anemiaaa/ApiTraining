import Foundation

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
    
    public func addPokemons(count: Int) {
        Pokemon.random(count: count) { [weak self] result in
            switch result {
            case .success(let pokemons):
                self?.pokemons = pokemons.map { Weak(object: $0) }
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
                }
            }
        }
    }
    
    public func showPokemonInfo(pokemon: Pokemon, completion: @escaping (Result<>) -> ()) {
        
    }
    
}
