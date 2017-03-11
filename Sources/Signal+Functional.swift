public extension Signal {
  func map<U>(transform: @escaping (T) -> U) -> Signal<U> {
    return ChildSignal(parent: self, forward: { t, sink in
      sink(transform(t))
    })
  }

  func flatMap<U>(transform: @escaping (T) -> U?) -> Signal<U> {
    return ChildSignal(parent: self, forward: { t, sink in
      if let u = transform(t) {
        sink(u)
      }
    })
  }

  func filter(filter: @escaping (T) -> Bool) -> Signal<T> {
    return ChildSignal(parent: self, forward: { t, sink in
      if filter(t) {
        sink(t)
      }
    })
  }
}
