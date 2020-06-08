import Foundation

public enum Composer {
    case
    satie,
    mozart,
    beethoven,
    brahms,
    debussy
    
    public var name: String {
        "composer_\(self)"
    }
}
