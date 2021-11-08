import Foundation

public class Pokemon: Codable {
    
    public let name: String
    
    init(name: String) {
        self.name = name
    }
}
