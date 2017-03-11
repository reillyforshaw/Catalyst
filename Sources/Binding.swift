class Binding {
  private let unbind: () -> Void

  init(unbind: @escaping () -> Void) {
    self.unbind = unbind
  }

  deinit {
    unbind()
  }
}
