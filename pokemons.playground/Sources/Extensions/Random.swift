import Foundation

public enum Result<Value, Error: Swift.Error> {
    
    case success(Value)
    case failure(Error)
}

public enum randomError: Error {
    
    case incorrectInputFormat
    case urlInit
}

extension Pokemon {
    
    public static func random(count: Int, completion: @escaping (Result<[Pokemon], randomError>) -> ()) {
        guard count > 0 else {
            completion(.failure(.incorrectInputFormat))
            return
        }
        guard let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=\(count)") else {
            completion(.failure(.urlInit))
            return
        }
        
        NetworkHelper.getData(NetworkDataNode<[Pokemon]>.self, url: url) {
            if let pokemons = $0.results {
                completion(.success(pokemons))
            }
        }
    }
}
