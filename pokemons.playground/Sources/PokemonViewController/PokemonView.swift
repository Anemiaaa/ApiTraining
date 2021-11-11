import Foundation

public class PokemonView {
    
    // MARK: -
    // MARK: Initialization
    
    public init() {}
    
    // MARK: -
    // MARK: Public
    
    public func display(text: String) {
        print(text)
    }
    
    public func display(text: [String]) {
        text.forEach { print($0) }
    }
}
