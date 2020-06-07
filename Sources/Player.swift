import Foundation
import Combine

public final class Player {
    public var config = CurrentValueSubject<Config, Never>(.init())
    public var track = CurrentValueSubject<Track, Never>(.satieGymnopedies)
    
    public init() { }
    
    public func trackEnds() {
        switch config.value.random {
        case .none:
            switch config.value.trackEnds {
            case .stop: break
            case .loop: track.value = track.value
            case .next: nextTrack()
            }
        case .track:
            track.value = Album.allCases.first { $0.tracks.contains(track.value) }.map { album in
                album.tracks[(0 ..< album.tracks.count).filter { $0 != album.tracks.firstIndex(of: track.value) }.randomElement()!]
            }!
        case .album:
            Album.allCases.first { $0.tracks.contains(track.value) }.map { album in
                Album.allCases.filter { $0 != album }.filter { config.value.purchases.contains($0.purchase) }.randomElement().map {
                    track.value = $0.tracks.randomElement()!
                }
            }
        }
    }
    
    private func albumEnds() {
        switch config.value.albumEnds {
        case .stop: break
        case .loop: track.value = Album.allCases.first { $0.tracks.contains(track.value) }!.tracks[0]
        case .next: nextAlbum()
        }
    }
    
    private func nextTrack() {
        Album.allCases.first { $0.tracks.contains(track.value) }.map { album in
            album.tracks.firstIndex(of: track.value).map {
                if $0 < album.tracks.count - 1 {
                    track.value = album.tracks[$0 + 1]
                } else {
                    albumEnds()
                }
            }
        }
    }
    
    private func nextAlbum() {
        Album.allCases.firstIndex { $0.tracks.contains(track.value) }.map { index in
            {
                ($0.first { $0.0 > index } ?? $0.first).map {
                    track.value = $0.1.tracks[0]
                }
            } ((0 ..< Album.allCases.count).compactMap {
                config.value.purchases.contains(Album.allCases[$0].purchase) ? ($0, Album.allCases[$0]) : nil
            }.filter { $0.0 != index })
        }
    }
}
