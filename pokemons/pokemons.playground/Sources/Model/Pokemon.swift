import Foundation

public class Pokemon: Codable {

    enum CodingKeys: String, CodingKey {
        
        case name
        case url
    }
    
    // MARK: -
    // MARK: Variables
    
    public let id = UUID()
    public let name: String
    public let url: URL
    
    // MARK: -
    // MARK: Initialization
    
    public init(name: String, url: URL) {
        self.name = name
        self.url = url
    }
}


// MARK: -
// MARK: Equatable

extension Pokemon: Equatable {
    
    public static func == (lhs: Pokemon, rhs: Pokemon) -> Bool {
        lhs.id == rhs.id
    }
}
