import XCTest
@testable import Catalyst

class SignalTests: XCTestCase {
	var binding: Binding?

  func testBindingPushingAndUnbinding() {
  	let (sink, signal) = Signal<Int>.make()

  	var values: [Int] = []
  	binding = signal.bind {
  		values.append($0)
  	}

  	sink(100)
  	RunLoop.main.run(until: Date().addingTimeInterval(0.01))
  	
  	binding = nil
  	sink(200)
  	RunLoop.main.run(until: Date().addingTimeInterval(0.01))

  	XCTAssertEqual(values, [100])
  }
}
