import Foundation
import RxSwift

public enum ControllerStates {
    
    case display(output: [DisplayOutput])
}

public class PokemonController {
    
    // MARK: -
    // MARK: Variables
    
    public var pokemons: [Pokemon] = []
    public var statesHandler = PublishSubject<ControllerStates>()
    
    private let api: PokemonAPI
    
    // MARK: -
    // MARK: Initialization
    
    public init(api: PokemonAPI) {
        self.api = api
    }
    
    // MARK: -
    // MARK: Public
    
    public func addPokemons(count: Int, completion: @escaping (Result<[Pokemon], PokemonApiError>) -> ()) {
        self.api.pokemons(count: count) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let node):
                self.pokemons = node.results
                
                completion(.success(self.pokemons))
                
            case .failure(let error):
                    
                self.statesHandler.onNext(
                    .display(output: [DisplayOutput(data: self.switchApiError(error: error))])
                )
                                           
                completion(.failure(error))
            }
        }
    }
    
    public func showPokemonInfo(pokemon: Pokemon) {
        guard let pokemon = self.pokemons.first(where: { $0.id == pokemon.id }) else { return }
        
        self.api.abilities(pokemon: pokemon) { [weak self] in
            self?.statesHandler.onNext(.display(output: [
                DisplayOutput(label: "name", data: pokemon.name),
                DisplayOutput(label: "abilities", data: "\($0)")
            ]))
        }
    }
    
    // MARK: -
    // MARK: Private
    
    private func switchApiError(error: PokemonApiError) -> String {
        switch error {
        case .incorrectInputFormat:
            return "В функцию передан параметр с необрабатываемым знаением"
        case .urlInit:
            return "Ошибка инициализации url"
        case .networkError(let error):
            return self.switchNetworkError(error: error)
        }
    }
    
    private func switchNetworkError(error: NetworkError) -> String {
        switch error {
        case .dataTaskError:
            return "data task error"
        case .dataCorrupted(let context):
            return "data corrupted: \(context)"
        case .keyNotFound(let key, let context):
            return "key \(key) not found, context: \(context)"
        case .valueNotFound(let value, let context):
            return "value \(value) not found, context \(context)"
        case .typeMismatch(let value, let context):
            return "type mismatch, value \(value), context \(context)"
        }
    }
    
}
