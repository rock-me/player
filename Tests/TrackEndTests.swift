import XCTest
import Combine
import Player

final class TrackEndTests: XCTestCase {
    private var player: Player!
    private var subs = Set<AnyCancellable>()
    
    override func setUp() {
        player = .init()
    }
    
    func testStop() {
        let expect = expectation(description: "")
        player.config.value.trackEnds = .stop
        player.track.sink { _ in
            expect.fulfill()
        }.store(in: &subs)
        player.start.sink {
            XCTFail()
        }.store(in: &subs)
        player.trackEnds()
        waitForExpectations(timeout: 1)
    }
    
    func testLoop() {
        let expectTrack = expectation(description: "")
        let expectStart = expectation(description: "")
        expectTrack.expectedFulfillmentCount = 2
        player.config.value.trackEnds = .loop
        player.track.value = .mozartEineKleineNachtmusik
        player.track.sink {
            XCTAssertEqual(.mozartEineKleineNachtmusik, $0)
            expectTrack.fulfill()
        }.store(in: &subs)
        player.start.sink {
            expectStart.fulfill()
        }.store(in: &subs)
        player.trackEnds()
        waitForExpectations(timeout: 1)
    }
    
    func testNext() {
        let expectTrack = expectation(description: "")
        let expectStart = expectation(description: "")
        player.config.value.trackEnds = .next
        player.track.value = Album.melancholy.tracks[0]
        player.track.sink {
            guard $0 == Album.melancholy.tracks[1] else { return }
            expectTrack.fulfill()
        }.store(in: &subs)
        player.start.sink {
            expectStart.fulfill()
        }.store(in: &subs)
        player.trackEnds()
        waitForExpectations(timeout: 1)
    }
    
    func testNextTake2() {
        let expectTrack = expectation(description: "")
        let expectStart = expectation(description: "")
        player.config.value.trackEnds = .next
        player.track.value = Album.mists.tracks[0]
        player.track.sink {
            guard $0 == Album.mists.tracks[1] else { return }
            expectTrack.fulfill()
        }.store(in: &subs)
        player.start.sink {
            expectStart.fulfill()
        }.store(in: &subs)
        player.trackEnds()
        waitForExpectations(timeout: 1)
    }
    
    func testNextTake3() {
        let expectTrack = expectation(description: "")
        let expectStart = expectation(description: "")
        player.config.value.trackEnds = .next
        player.track.value = Album.mists.tracks[Album.mists.tracks.count - 2]
        player.track.sink {
            guard $0 == Album.mists.tracks[Album.mists.tracks.count - 1] else { return }
            expectTrack.fulfill()
        }.store(in: &subs)
        player.start.sink {
            expectStart.fulfill()
        }.store(in: &subs)
        player.trackEnds()
        waitForExpectations(timeout: 1)
    }
    
    func testNextLastIndex() {
        let expect = expectation(description: "")
        player.config.value.trackEnds = .next
        player.config.value.albumEnds = .stop
        player.track.value = Album.mists.tracks[Album.mists.tracks.count - 1]
        player.track.sink { _ in
            expect.fulfill()
        }.store(in: &subs)
        player.start.sink {
            XCTFail()
        }.store(in: &subs)
        player.trackEnds()
        waitForExpectations(timeout: 1)
    }
}
