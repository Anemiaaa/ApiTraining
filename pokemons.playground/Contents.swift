import UIKit
import Foundation

Pokemon.random(count: 10) { pokemons in
    pokemons.forEach { print($0.name) }
}


