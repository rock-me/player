import XCTest
import Combine
import Player

final class RandomTests: XCTestCase {
    private var player: Player!
    private var subs = Set<AnyCancellable>()
    
    override func setUp() {
        player = .init()
    }
    
    func testTrack() {
        let expect = expectation(description: "")
        var prev = Album.mists.tracks.last!
        expect.expectedFulfillmentCount = 100
        player.config.value.trackEnds = .next
        player.config.value.random = .track
        player.track.value = prev
        player.track.sink {
            guard $0 != prev else { return }
            prev = $0
            expect.fulfill()
        }.store(in: &subs)
        (0 ..< 100).forEach { _ in
            self.player.trackEnds()
        }
        waitForExpectations(timeout: 1)
    }
}
