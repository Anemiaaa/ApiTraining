import UIKit
import Foundation

let controller = PokemonController()
let view = PokemonView(controller: controller)

controller.addPokemons(count: 10) { result in
    switch result {
    case .success(let pokemons):
        if let pokemon = pokemons.randomElement() {
            controller.showPokemonInfo(pokemon: pokemon)
        }
    case .failure(let error):
        print(error)
    }
}
