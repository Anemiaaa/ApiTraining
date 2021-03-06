//
//  main.swift
//  pokemons
//
//  Created by mac on 18.11.2021.
//

import Foundation

let controller = PokemonController(api: PokemonNetworkAPI())
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
