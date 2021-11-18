import Foundation

public enum NetworkError: Error {
    
    case dataTaskError
    
    case dataCorrupted(DecodingError.Context)
    
    case keyNotFound(CodingKey, DecodingError.Context)
    
    case valueNotFound(Any.Type, DecodingError.Context)
    
    case typeMismatch(Any.Type, DecodingError.Context)
    
}

public class NetworkHelper {
    
    @discardableResult
    static func getData<DataType: Codable>(_ dataType: DataType.Type, url: URL, completion: @escaping (Result<DataType, NetworkError>) -> ()) -> URLSessionDataTask {
        let task = URLSession.shared.dataTask(with: url) { data, response, error in
            
            if let data = data {
                do {
                    let decodedJson = try JSONDecoder().decode(DataType.self, from: data)

                    completion(.success(decodedJson))
                }
                catch let DecodingError.dataCorrupted(context) {
                    completion(.failure(.dataCorrupted(context)))
                }
                catch let DecodingError.keyNotFound(key, context) {
                    completion(.failure(.keyNotFound(key, context)))
                }
                catch let DecodingError.valueNotFound(value, context) {
                    completion(.failure(.valueNotFound(value, context)))
                }
                catch let DecodingError.typeMismatch(type, context)  {
                    completion(.failure(.typeMismatch(type, context)))
                }
                catch {
                    completion(.failure(.dataTaskError))
                }
            }
           
        }
        task.resume()
        
        return task
    }
}

