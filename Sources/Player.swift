import Foundation
import Combine

public final class Player {
    public var start = PassthroughSubject<Void, Never>()
    public var config = CurrentValueSubject<Config, Never>(.init())
    public var track = CurrentValueSubject<Track, Never>(.satieGymnopedies)
    public var previousable = CurrentValueSubject<Bool, Never>(false)
    public var nextable = CurrentValueSubject<Bool, Never>(false)
    private var subs = Set<AnyCancellable>()
    
    public init() {
        track.sink { [weak self] in
            self?.previousable.value = $0.index > 0
            self?.nextable.value = $0.index < $0.album.tracks.count - 1
        }.store(in: &subs)
    }
    
    public func trackEnds() {
        switch config.value.random {
        case .none:
            switch config.value.trackEnds {
            case .stop:
                break
            case .loop:
                track.value = track.value
                start.send()
            case .next:
                nextTrack()
            }
        case .track:
            track.value = track.value.album.tracks.filter { $0 != track.value }.randomElement()!
            start.send()
        case .album:
            Album.allCases.filter { config.value.purchases.contains($0.purchase) }.filter { $0 != track.value.album }.randomElement().map {
                track.value = $0.tracks.randomElement()!
                start.send()
            }
        }
    }
    
    public func previous() {
        track.value = track.value.previous
    }
    
    public func next() {
        track.value = track.value.next
    }
    
    private func albumEnds() {
        switch config.value.albumEnds {
        case .stop:
            break
        case .loop:
            track.value = track.value.album.tracks[0]
            start.send()
        case .next:
            nextAlbum()
        }
    }
    
    private func nextTrack() {
        if nextable.value {
            next()
            start.send()
        } else {
            albumEnds()
        }
    }
    
    private func nextAlbum() {
        {
            ($0.first { $0.index > track.value.album.index } ?? $0.first).map {
                track.value = $0.tracks[0]
                start.send()
            }
        } (Album.allCases.filter { config.value.purchases.contains($0.purchase) }.filter { $0 != track.value.album })
    }
}
