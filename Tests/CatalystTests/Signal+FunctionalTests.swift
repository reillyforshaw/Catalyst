import XCTest
@testable import Catalyst

class Signal_FunctionalTests: XCTestCase {
  var binding: Binding?

  func testMap() {
    let (sink, signal) = Signal<Int>.make()

    var squares: [Int] = []
    binding = signal.map { $0 * $0 }.bind {
      squares.append($0)
    }

    sink(1)
    sink(2)
    RunLoop.main.run(until: Date().addingTimeInterval(0.01))

    binding = nil
    sink(3)
    RunLoop.main.run(until: Date().addingTimeInterval(0.01))

    XCTAssertEqual(squares, [1, 4])
  }

  func testFlatMap() {
    let (sink, signal) = Signal<String>.make()

    var ints: [Int] = []
    binding = signal.flatMap { Int($0) }.bind {
      ints.append($0)
    }

    sink("mlerm")
    sink("1")
    RunLoop.main.run(until: Date().addingTimeInterval(0.01))

    binding = nil
    sink("yarp")
    sink("2")
    RunLoop.main.run(until: Date().addingTimeInterval(0.01))

    XCTAssertEqual(ints, [1])
  }

  func testFilter() {
    let (sink, signal) = Signal<Int>.make()

    var evens: [Int] = []
    binding = signal.filter { $0 % 2 == 0 }.bind {
      evens.append($0)
    }

    sink(1)
    sink(2)
    RunLoop.main.run(until: Date().addingTimeInterval(0.01))

    binding = nil
    sink(3)
    sink(4)
    RunLoop.main.run(until: Date().addingTimeInterval(0.01))

    XCTAssertEqual(evens, [2])
  }
}
