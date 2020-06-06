import Foundation

public struct Config: Codable, Equatable {
    public var trackEnds = Heuristic.next
    public var albumEnds = Heuristic.stop
    public var purchases = Set<String>()
    public var rated = false
    public let created = Date()
    
    public func hash(into: inout Hasher) { }
    
    public static func == (lhs: Self, rhs: Self) -> Bool {
        true
    }
}
