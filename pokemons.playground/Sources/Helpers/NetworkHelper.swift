import Foundation

public struct NetworkDataNode<ContainedObjectType: Codable>: Codable {
    
    var count: Int?
    var next: URL?
    var previous: URL?
    var results: ContainedObjectType?
}

public class NetworkHelper {
    
    static func getData<DataType: Codable>(_ dataType: DataType.Type, url: URL, completion: @escaping (DataType) -> ()) -> URLSessionDataTask {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
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
           
        }
        task.resume()
        
        return task
    }
}

