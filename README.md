# Catalyst

### Usage
```swift
let (sink, signal) = Signal<String>.make()

let binding = signal.flatMap { Int($0) }.map { $0 * $0 }.bind {
  print($0)
}

sink("1")
sink("mlerm")
sink("2")
sink("3")
```
```
1
4
9
```
