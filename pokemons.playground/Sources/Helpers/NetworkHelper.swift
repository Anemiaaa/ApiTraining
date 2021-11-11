import Foundation

public struct NetworkDataNode<ContainedObjectType: Codable>: Codable {
    
    var count: Int
    var next: URL?
    var previous: URL?
    var results: ContainedObjectType
}

public class NetworkHelper {
    
    @discardableResult
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
                catch let DecodingError.dataCorrupted(context) {
                    print(context)
                } catch let DecodingError.keyNotFound(key, context) {
                    print("Key '\(key)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.valueNotFound(value, context) {
                    print("Value '\(value)' not found:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch let DecodingError.typeMismatch(type, context)  {
                    print("Type '\(type)' mismatch:", context.debugDescription)
                    print("codingPath:", context.codingPath)
                } catch {
                    print("error: ", error)
                }
            }
           
        }
        task.resume()
        
        return task
    }
}

