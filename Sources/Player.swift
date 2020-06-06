import Foundation
import Combine

public final class Player {
    public var config = CurrentValueSubject<Config, Never>(.init())
    public var track = CurrentValueSubject<Track, Never>(.satieGymnopedies)
    
    public init() { }
    
    public func trackEnds() {
        switch config.value.trackEnds {
        case .stop: break
        case .loop: track.value = track.value
        case .next: next()
        }
    }
    
    private func next() {
        track.value = Album.tra
    }
}
