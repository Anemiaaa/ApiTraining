import Foundation

public struct Pokemon: Codable {
    
    public let name: String
    
    init(name: String) {
        self.name = name
    }
}
