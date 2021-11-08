import Foundation

extension Pokemon {
    
    public static func random(count: Int, completion: @escaping ([Pokemon]) -> ()) {
        guard count > 0 else { return }
        
        let url = URL(string: "https://pokeapi.co/api/v2/pokemon?limit=\(count)")

        if let url = url {
            URLSession.shared.dataTask(with: url) { data, response, error in
                if let error = error {
                    print(error)
                }
                
                if let data = data {
                    do {
                        let json = try JSONSerialization.jsonObject(with: data, options: [])
                
                        
                        if let json = json as? [String: Any],
                           let resultArray = json["results"] as? [[String: String]]
                        {
                            completion(resultArray.compactMap {
                                if let name = $0["name"] {
                                    return Pokemon(name: name)
                                }
                                return nil
                            })
                        }
                    }
                    catch {
                        print("Error during JSON serialization: \(error.localizedDescription)")
                    }
                }
               
            }.resume()
        }
    }
}
