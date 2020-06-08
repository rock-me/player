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
        }.store(in: &subs)
    }
    
    public func trackEnds() {
        switch config.value.random {
        case .none:
            switch config.value.trackEnds {
            case .stop: break
            case .loop: track.value = track.value
            case .next: nextTrack()
            }
        case .track:
            track.value = track.value.album.tracks.filter { $0 != track.value }.randomElement()!
        case .album:
            Album.allCases.filter { config.value.purchases.contains($0.purchase) }.filter { $0 != track.value.album }.randomElement().map {
                track.value = $0.tracks.randomElement()!
            }
        }
    }
    
    private func albumEnds() {
        switch config.value.albumEnds {
        case .stop: break
        case .loop: track.value = track.value.album.tracks[0]
        case .next: nextAlbum()
        }
    }
    
    private func nextTrack() {
        if track.value.index < track.value.album.tracks.count - 1 {
            track.value = track.value.album.tracks[track.value.index + 1]
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
