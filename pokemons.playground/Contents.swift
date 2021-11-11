import UIKit
import Foundation

let view = PokemonView()
let controller = PokemonController(view: view)

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

//print(controller.pokemons)
//if let pokemon = controller.pokemons.randomElement()?.object {
//    controller.showPokemonInfo(pokemon: pokemon)
//}


