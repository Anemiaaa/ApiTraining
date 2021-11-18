import Foundation

public struct NetworkDataNode<ContainedObjectType: Codable>: Codable {
    
    var count: Int
    var next: URL?
    var previous: URL?
    var results: ContainedObjectType
}
