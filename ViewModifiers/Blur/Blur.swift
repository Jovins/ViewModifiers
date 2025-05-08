import SwiftUI

extension View {
    /// A modifier that applies a gradient blur effect to the view.
    ///
    /// - Parameters:
    ///   - radius: The total radius of the blur effect when fully applied.
    ///   - offset: The distance from the view's edge to where the effect begins, relative to the view's size.
    ///   - distance: The distance from the offset to where the effect is fully applied, relative to the view's size.
    ///   - direction: The direction in which the effect is applied.
    func blur(radius: CGFloat = 8.0,
              offset: CGFloat = 0.3,
              distance: CGFloat = 0.4,
              direction: BlurDirection = .down) -> some View {
        assert(radius >= 0.0, "Radius must be greater than or equal to 0")
        assert(offset >= 0.0 && offset <= 1.0, "Offset must be between 0 and 1")
        assert(distance >= 0.0 && distance <= 1.0, "distance must be between 0 and 1")
        if #available(iOS 17.0, macOS 14.0, tvOS 17.0, visionOS 1.0, *) {
            return modifier(BlurModifier(radius: radius,
                                         offset: offset,
                                         distance: distance,
                                         direction: direction))
        } else {
            return modifier(CompatibilityModifier(radius: radius,
                                                  offset: offset,
                                                  distance: distance,
                                                  direction: direction))
        }
    }
}
