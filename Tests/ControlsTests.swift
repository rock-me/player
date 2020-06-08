import XCTest
import Combine
import Player

final class ControlsTests: XCTestCase {
    private var player: Player!
    private var subs = Set<AnyCancellable>()
    
    override func setUp() {
        player = .init()
    }
    
    func testBackableFirst() {
        let expect = expectation(description: "")
        player.backable.dropFirst().sink {
            XCTAssertFalse($0)
            expect.fulfill()
        }.store(in: &subs)
        player.track.value = Album.mists.tracks.first!
        waitForExpectations(timeout: 1)
    }
    
    func testBackableSecond() {
        let expect = expectation(description: "")
        player.backable.dropFirst().sink {
            XCTAssertTrue($0)
            expect.fulfill()
        }.store(in: &subs)
        player.track.value = Album.mists.tracks[1]
        waitForExpectations(timeout: 1)
    }
}
