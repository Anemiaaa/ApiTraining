import Foundation

public struct NetworkDataNode<ContainedObjectType: Codable> {
    
    var count: Int?
    var next: URL?
    var previous: URL?
    var results: [ContainedObjectType]?
}

extension NetworkDataNode: Codable {
    
    enum CodingKeys: String, CodingKey {
        
        case count
        case next
        case previous
        case results
    }
    
    public init(from decoder: Decoder) throws {
        let container = try decoder.container(keyedBy: CodingKeys.self)
        
        self.count = try? container.decode(Int.self, forKey: .count)
        self.next = try? container.decode(URL.self, forKey: .next)
        self.previous = try? container.decode(URL.self, forKey: .previous)
        self.results = try? container.decode([ContainedObjectType].self, forKey: .results)
    }
}

public class NetworkHelper {
    
    static func getData<DataType: Codable>(_ dataType: DataType.Type, url: URL, completion: @escaping (DataType) -> ()) {
        URLSession.shared.dataTask(with: url) { data, response, error in
            if let error = error {
                print(error)
            }
            
            if let data = data {
                
                do {
                    let decodedJson = try JSONDecoder().decode(DataType.self, from: data)
                    
                    completion(decodedJson)
                }
                catch {
                    print("Error during JSON serialization: \(error.localizedDescription)")
                }
            }
           
        }.resume()
    }
}
