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
        let expectTrack = expectation(description: "")
        let expectStart = expectation(description: "")
        var prev = Album.mists.tracks.last!
        expectTrack.expectedFulfillmentCount = 100
        expectStart.expectedFulfillmentCount = 100
        player.config.value.random = .track
        player.track.value = prev
        player.track.sink {
            guard $0 != prev else { return }
            prev = $0
            expectTrack.fulfill()
        }.store(in: &subs)
        player.start.sink {
            expectStart.fulfill()
        }.store(in: &subs)
        (0 ..< 100).forEach { _ in
            self.player.trackEnds()
        }
        waitForExpectations(timeout: 1)
    }
    
    func testAlbumNone() {
        let expect = expectation(description: "")
        player.config.value.random = .album
        player.track.value = Album.mists.tracks.randomElement()!
        player.track.sink { _ in
            expect.fulfill()
        }.store(in: &subs)
        player.start.sink {
            XCTFail()
        }.store(in: &subs)
        player.trackEnds()
        waitForExpectations(timeout: 1)
    }
    
    func testAlbumOne() {
        let expectTrack = expectation(description: "")
        let expectStart = expectation(description: "")
        var prev = Album.mists
        expectTrack.expectedFulfillmentCount = 100
        expectStart.expectedFulfillmentCount = 100
        player.config.value.random = .album
        player.config.value.purchases.insert(Album.melancholy.purchase)
        player.track.value = Album.mists.tracks.randomElement()!
        player.track.sink { track in
            guard
                let album = Album.allCases.first(where: { $0.tracks.contains(track) }),
                album != prev
            else { return }
            prev = album
            expectTrack.fulfill()
        }.store(in: &subs)
        player.start.sink {
            expectStart.fulfill()
        }.store(in: &subs)
        (0 ..< 100).forEach { _ in
            self.player.trackEnds()
        }
        waitForExpectations(timeout: 1)
    }
}
