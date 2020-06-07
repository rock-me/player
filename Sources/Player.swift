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
        case .next: nextTrack()
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
        
    }
}
