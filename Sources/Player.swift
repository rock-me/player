import Foundation
import Combine

public final class Player {
    public var config = CurrentValueSubject<Config, Never>(.init())
    public var track = CurrentValueSubject<Track, Never>(.satieGymnopedies)
    public var backable = CurrentValueSubject<Bool, Never>(false)
    public var forwardable = CurrentValueSubject<Bool, Never>(false)
    private var subs = Set<AnyCancellable>()
    
    public init() {
        track.sink { [weak self] in
            self?.backable.value = $0.index > 0
            self?.forwardable.value = $0.index < $0.album.tracks.count - 1
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
            case .next:
                nextTrack()
            }
        case .track:
            track.value = track.value.album.tracks.filter { $0 != track.value }.randomElement()!
        case .album:
            Album.allCases.filter { config.value.purchases.contains($0.purchase) }.filter { $0 != track.value.album }.randomElement().map {
                track.value = $0.tracks.randomElement()!
            }
        }
    }
    
    public func back() {
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
        case .next:
            nextAlbum()
        }
    }
    
    private func nextTrack() {
        if forwardable.value {
            next()
        } else {
            albumEnds()
        }
    }
    
    private func nextAlbum() {
        {
            ($0.first { $0.index > track.value.album.index } ?? $0.first).map {
                track.value = $0.tracks[0]
            }
        } (Album.allCases.filter { config.value.purchases.contains($0.purchase) }.filter { $0 != track.value.album })
    }
}
