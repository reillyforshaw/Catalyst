import XCTest
@testable import Catalyst

class CatalystTests: XCTestCase {
    func testExample() {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
        XCTAssertEqual(Catalyst().text, "Hello, World!")
    }


    static var allTests : [(String, (CatalystTests) -> () throws -> Void)] {
        return [
            ("testExample", testExample),
        ]
    }
}
