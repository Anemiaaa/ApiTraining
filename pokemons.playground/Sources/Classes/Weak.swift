import Foundation

public class Weak<T: AnyObject & Equatable>: Equatable {
    
    // MARK: -
    // MARK: Variables

    public weak var object: T?
    
    // MARK: -
    // MARK: Initialization
    
    init (object: T) {
        self.object = object
    }
    
    // MARK: -
    // MARK: Equatable

    public static func == (lhs: Weak<T>, rhs: Weak<T>) -> Bool {
        lhs.object == rhs.object
    }
}
