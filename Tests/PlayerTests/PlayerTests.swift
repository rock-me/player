import XCTest
@testable import Player

final class PlayerTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct
        // results.
        XCTAssertEqual(Player().text, "Hello, World!")
    }

    static var allTests = [
        ("testExample", testExample),
    ]
}
