import XCTest
import Combine
@testable import Player

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
        player.trackEnds()
        waitForExpectations(timeout: 1)
    }
    
    func testLoop() {
        let expect = expectation(description: "")
        expect.expectedFulfillmentCount = 2
        player.config.value.trackEnds = .loop
        player.track.value = .mozartEineKleineNachtmusik
        player.track.sink {
            XCTAssertEqual(.mozartEineKleineNachtmusik, $0)
            expect.fulfill()
        }.store(in: &subs)
        player.trackEnds()
        waitForExpectations(timeout: 1)
    }
    
    func testNext() {
        let expect = expectation(description: "")
        player.config.value.trackEnds = .next
        player.track.value = Album.melancholy.tracks[0]
        player.track.sink {
            guard $0 == Album.melancholy.tracks[1] else { return }
            expect.fulfill()
        }.store(in: &subs)
        player.trackEnds()
        waitForExpectations(timeout: 1)
    }
}
