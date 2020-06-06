import XCTest
@testable import Player

final class CompletionTests: XCTestCase {
    func testTracks() {
        Track.allCases.forEach { track in
            XCTAssertEqual(1, Album.allCases.filter { $0.tracks.contains(track) }.count)
        }
    }
}
