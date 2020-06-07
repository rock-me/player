import XCTest
import Combine
@testable import Player

final class AlbumEndTests: XCTestCase {
    private var player: Player!
    private var subs = Set<AnyCancellable>()
    
    override func setUp() {
        player = .init()
    }
    
    func testStop() {
        let expect = expectation(description: "")
        player.config.value.trackEnds = .next
        player.config.value.albumEnds = .stop
        player.track.value = Album.mists.tracks[Album.mists.tracks.count - 1]
        player.track.sink { _ in
            expect.fulfill()
        }.store(in: &subs)
        player.trackEnds()
        waitForExpectations(timeout: 1)
    }
    
    func testLoop() {
        let expect = expectation(description: "")
        player.config.value.trackEnds = .next
        player.config.value.albumEnds = .loop
        player.track.value = Album.mists.tracks[Album.mists.tracks.count - 1]
        player.track.sink {
            guard $0 == Album.mists.tracks[0] else { return }
            expect.fulfill()
        }.store(in: &subs)
        player.trackEnds()
        waitForExpectations(timeout: 1)
    }
}
