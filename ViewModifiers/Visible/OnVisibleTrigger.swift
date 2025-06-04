import Foundation

struct OnVisibleTrigger: Equatable {
    private var count: UInt64 = 0
    mutating func send() {
        count &+= 1
    }
}
