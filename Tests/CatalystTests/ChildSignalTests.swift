import XCTest
@testable import Catalyst

class ChildSignalTests: XCTestCase {
  var binding: Binding?
  weak var weakSignal: Signal<Int>?

  func testChainedSignalOwnership() {
    let (sink, signal) = Signal<String>.make()

    // Intermediate signal is not locally owned!
    let squaredIntSignal = signal.flatMap { Int($0) }.map { $0 * $0 }

    var squaredInts: [Int] = []
    binding = squaredIntSignal.bind {
      squaredInts.append($0)
    }

    sink("1")
    sink("2")
    sink("3")
    RunLoop.main.run(until: Date().addingTimeInterval(0.01))

    XCTAssertEqual(squaredInts, [1, 4, 9])
  }

  func testParentAloneDoesNotKeepAlive() {
    let (_, signal) = Signal<Int>.make()

    var locallyOwned: Signal<Int>? = signal.filter { _ in false }
    weakSignal = locallyOwned
    XCTAssertNotNil(weakSignal)

    locallyOwned = nil
    XCTAssertNil(weakSignal)
  }
}
