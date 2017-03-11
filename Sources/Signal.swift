import Foundation

class Signal<T> {
  typealias Sink = (T) -> Void
  typealias Listener = (T) -> Void

  var listeners: [UUID : Listener] = [:]
  let queue: DispatchQueue

  static func make(queue: DispatchQueue = .main) -> (Sink, Signal<T>) {
    let signal = Signal(queue: queue)

    return (signal.push, signal)
  }

  private init(queue: DispatchQueue) {
    self.queue = queue
  }

  func bind(listener: @escaping Listener) -> Binding {
    let token = UUID()
    let binding = Binding(unbind: { [weak self] in
      _ = self?.listeners.removeValue(forKey: token)
    })
    listeners[token] = listener

    return binding
  }

  private func push(value: T) {
    queue.async {
      for listener in self.listeners.values {
        listener(value)
      }
    }
  }
}
