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
        player.previousable.dropFirst().sink {
            XCTAssertFalse($0)
            expect.fulfill()
        }.store(in: &subs)
        player.track.value = Album.mists.tracks.first!
        waitForExpectations(timeout: 1)
    }
    
    func testBackableSecond() {
        let expect = expectation(description: "")
        player.previousable.dropFirst().sink {
            XCTAssertTrue($0)
            expect.fulfill()
        }.store(in: &subs)
        player.track.value = Album.mists.tracks[1]
        waitForExpectations(timeout: 1)
    }
    
    func testForwardableLast() {
        let expect = expectation(description: "")
        player.nextable.dropFirst().sink {
            XCTAssertFalse($0)
            expect.fulfill()
        }.store(in: &subs)
        player.track.value = Album.mists.tracks.last!
        waitForExpectations(timeout: 1)
    }
    
    func testForwardablePreviousToLast() {
        let expect = expectation(description: "")
        player.nextable.dropFirst().sink {
            XCTAssertTrue($0)
            expect.fulfill()
        }.store(in: &subs)
        player.track.value = Album.mists.tracks[Album.mists.tracks.count - 2]
        waitForExpectations(timeout: 1)
    }
    
    func testBackwards() {
        let expect = expectation(description: "")
        player.track.value = Album.mists.tracks.last!
        player.track.dropFirst().sink {
            XCTAssertEqual(Album.mists.tracks[Album.mists.tracks.count - 2], $0)
            expect.fulfill()
        }.store(in: &subs)
        player.previous()
        waitForExpectations(timeout: 1)
    }
    
    func testForwards() {
        let expect = expectation(description: "")
        player.track.value = Album.mists.tracks.first!
        player.track.dropFirst().sink {
            XCTAssertEqual(Album.mists.tracks[1], $0)
            expect.fulfill()
        }.store(in: &subs)
        player.next()
        waitForExpectations(timeout: 1)
    }
}
