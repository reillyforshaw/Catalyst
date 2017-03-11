import Foundation

internal class ChildSignal<T, U>: Signal<U> {
  typealias Forward = (T, Sink) -> Void

  private var parentBinding: Binding!
  private var keepAlive: ChildSignal<T, U>?

  init(parent: Signal<T>, forward: @escaping Forward) {
    super.init(queue: parent.queue)

    self.parentBinding = parent.bind { [weak self] in
      if let push = self?.push {
        forward($0, push)
      }
    }
  }

  override func bind(listener: @escaping Listener) -> Binding {
    keepAlive = self

    return super.bind(listener: listener)
  }

  override func unbind(token: UUID) {
    super.unbind(token: token)

    if self.listeners.isEmpty {
      keepAlive = nil
    }
  }
}