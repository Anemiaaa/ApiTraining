import Foundation

extension Pokemon {
    
    public static func random(count: Int, completion: @escaping ([Pokemon]) -> ()) {
        guard count > 0,
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=\(count)")
        else { return }
        
        NetworkHelper.getData(NetworkDataNode<Pokemon>.self, url: url) {
            if let pokemons = $0.results {
                completion(pokemons)
            }
        }
    }
}
