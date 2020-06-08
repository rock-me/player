import XCTest
import Combine
import Player

final class ControlsTests: XCTestCase {
    private var player: Player!
    private var subs = Set<AnyCancellable>()
    
    override func setUp() {
        player = .init()
    }
    
    func testPreviousableFirst() {
        let expect = expectation(description: "")
        player.previousable.dropFirst().sink {
            XCTAssertFalse($0)
            expect.fulfill()
        }.store(in: &subs)
        player.track.value = Album.mists.tracks.first!
        waitForExpectations(timeout: 1)
    }
    
    func testPreviousableSecond() {
        let expect = expectation(description: "")
        player.previousable.dropFirst().sink {
            XCTAssertTrue($0)
            expect.fulfill()
        }.store(in: &subs)
        player.track.value = Album.mists.tracks[1]
        waitForExpectations(timeout: 1)
    }
    
    func testNextableLast() {
        let expect = expectation(description: "")
        player.nextable.dropFirst().sink {
            XCTAssertFalse($0)
            expect.fulfill()
        }.store(in: &subs)
        player.track.value = Album.mists.tracks.last!
        waitForExpectations(timeout: 1)
    }
    
    func testNextablePreviousToLast() {
        let expect = expectation(description: "")
        player.nextable.dropFirst().sink {
            XCTAssertTrue($0)
            expect.fulfill()
        }.store(in: &subs)
        player.track.value = Album.mists.tracks[Album.mists.tracks.count - 2]
        waitForExpectations(timeout: 1)
    }
    
    func testPrevious() {
        let expect = expectation(description: "")
        player.track.value = Album.mists.tracks.last!
        player.track.dropFirst().sink {
            XCTAssertEqual(Album.mists.tracks[Album.mists.tracks.count - 2], $0)
            expect.fulfill()
        }.store(in: &subs)
        player.previous()
        waitForExpectations(timeout: 1)
    }
    
    func testNext() {
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
