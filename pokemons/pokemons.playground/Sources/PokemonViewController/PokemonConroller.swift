import Foundation
import RxSwift

public enum ControllerStates {
    
    case display(output: [DisplayOutput])
}

public class PokemonController {
    
    // MARK: -
    // MARK: Variables
    
    public var pokemons: [PokemonCodable] = []
    public var statesHandler = PublishSubject<ControllerStates>()
    
    private let api: PokemonAPI
    
    // MARK: -
    // MARK: Initialization
    
    public init(api: PokemonAPI) {
        self.api = api
    }
    
    // MARK: -
    // MARK: Public
    
    public func addPokemons<DataType: PokemonCodable>(count: Int, dataType: DataType, completion: @escaping (Result<[PokemonCodable], randomError>) -> ()) {
        self.api.random(count: count, dataType: dataType) { [weak self] result in
            guard let self = self else { return }
            
            switch result {
            case .success(let node):
                self.pokemons = node.results
                
                completion(.success(self.pokemons))
                
            case .failure(let error):
                    
                self.statesHandler.onNext(
                    .display(output: [DisplayOutput(data: self.switchError(error: error))])
                )
                                           
                completion(.failure(error))
            }
        }
    }
    
    public func showPokemonInfo(pokemon: PokemonCodable) {
        guard let pokemon = self.pokemons.first(where: { $0.id == pokemon.id }) else { return }
        
        NetworkHelper.getData(PokemonAbilities.self, url: pokemon.url) { [weak self] abilities in

            self?.statesHandler.onNext(.display(output: [
                DisplayOutput(label: "name", data: pokemon.name),
                DisplayOutput(label: "abilities", data: "\(abilities.abilities.map { $0 })")
            ]))
        }
    }
    
    // MARK: -
    // MARK: Private
    
    private func switchError(error: randomError) -> String {
        switch error {
        case .incorrectInputFormat:
            return "В функцию передан параметр с необрабатываемым знаением"
        case .urlInit:
            return "Ошибка инициализации url"
        }
        
    }
    
}
