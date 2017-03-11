import XCTest
@testable import Catalyst

class BindingTests: XCTestCase {
  func testDeinitCallsUnbind() {
    let unbindExpectation = expectation(description: "Expect unbind to be called during deinit.")
    
    _ = Binding(unbind: {
      unbindExpectation.fulfill()
    })

    waitForExpectations(timeout: 1, handler: nil)
  }
}
