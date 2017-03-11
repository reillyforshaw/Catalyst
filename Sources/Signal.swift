import Foundation

public class Signal<T> {
  public typealias Sink = (T) -> Void
  public typealias Listener = (T) -> Void

  internal var listeners: [UUID : Listener] = [:]
  let queue: DispatchQueue

  public static func make(queue: DispatchQueue = .main) -> (Sink, Signal<T>) {
    let signal = Signal(queue: queue)

    return (signal.push, signal)
  }

  internal init(queue: DispatchQueue) {
    self.queue = queue
  }

  public func bind(listener: @escaping Listener) -> Binding {
    let token = UUID()
    let binding = Binding(unbind: { [weak self] in
      self?.unbind(token: token)
    })
    listeners[token] = listener

    return binding
  }

  internal func push(value: T) {
    queue.async {
      for listener in self.listeners.values {
        listener(value)
      }
    }
  }

  internal func unbind(token: UUID) {
    _ = listeners.removeValue(forKey: token)
  }
}
