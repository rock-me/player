import Foundation

public enum Composer: CaseIterable {
    case
    satie,
    mozart,
    beethoven,
    brahms,
    debussy
    
    public var name: String {
        "composer_\(self)_name"
    }
}
