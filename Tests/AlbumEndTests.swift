import XCTest
import Combine
import Player

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
    
    func testNextNoOther() {
        let expect = expectation(description: "")
        player.config.value.trackEnds = .next
        player.config.value.albumEnds = .next
        player.track.value = Album.mists.tracks[Album.mists.tracks.count - 1]
        player.track.sink { _ in
            expect.fulfill()
        }.store(in: &subs)
        player.trackEnds()
        waitForExpectations(timeout: 1)
    }
    
    func testNextForward() {
        let expect = expectation(description: "")
        player.config.value.trackEnds = .next
        player.config.value.albumEnds = .next
        player.config.value.purchases.insert(Album.melancholy.purchase)
        player.track.value = Album.mists.tracks[Album.mists.tracks.count - 1]
        player.track.sink {
            guard $0 == Album.melancholy.tracks[0] else { return }
            expect.fulfill()
        }.store(in: &subs)
        player.trackEnds()
        waitForExpectations(timeout: 1)
    }
    
    func testNextForwardAhead() {
        let expect = expectation(description: "")
        player.config.value.trackEnds = .next
        player.config.value.albumEnds = .next
        player.config.value.purchases.insert(Album.tension.purchase)
        player.track.value = Album.mists.tracks[Album.mists.tracks.count - 1]
        player.track.sink {
            guard $0 == Album.tension.tracks[0] else { return }
            expect.fulfill()
        }.store(in: &subs)
        player.trackEnds()
        waitForExpectations(timeout: 1)
    }
    
    func testNextMany() {
        let expect = expectation(description: "")
        player.config.value.trackEnds = .next
        player.config.value.albumEnds = .next
        player.config.value.purchases.insert(Album.melancholy.purchase)
        player.config.value.purchases.insert(Album.tension.purchase)
        player.config.value.purchases.insert(Album.dawn.purchase)
        player.track.value = Album.mists.tracks[Album.mists.tracks.count - 1]
        player.track.sink {
            guard $0 == Album.melancholy.tracks[0] else { return }
            expect.fulfill()
        }.store(in: &subs)
        player.trackEnds()
        waitForExpectations(timeout: 1)
    }
    
    func testNextLast() {
        let expect = expectation(description: "")
        player.config.value.trackEnds = .next
        player.config.value.albumEnds = .next
        player.config.value.purchases = []
        player.track.value = Album.allCases.last!.tracks[Album.allCases.last!.tracks.count - 1]
        player.track.sink { _ in
            expect.fulfill()
        }.store(in: &subs)
        player.trackEnds()
        waitForExpectations(timeout: 1)
    }
    
    func testNextBackwards() {
        let expect = expectation(description: "")
        player.config.value.trackEnds = .next
        player.config.value.albumEnds = .next
        player.track.value = Album.tension.tracks[Album.tension.tracks.count - 1]
        player.track.sink {
            guard $0 == Album.mists.tracks[0] else { return }
            expect.fulfill()
        }.store(in: &subs)
        player.trackEnds()
        waitForExpectations(timeout: 1)
    }
}
