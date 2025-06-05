import SwiftUI

extension View {
    /// Replace a view's contents with a gradient.
    ///
    /// - Parameters:
    ///   - colors: The colors of the blobs in the gradient.
    ///   - background: The background view of the gradient.
    ///   - speed: The speed at which the blobs move, if they're moving.
    ///   - animate: Whether or not the blobs should move.
    func irregularGradient<Background: View>(colors: [Color],
                                             background: @autoclosure @escaping () -> Background,
                                             speed: Double = 1,
                                             animate: Bool = true) -> some View {
        return self.overlay(IrregularGradient(colors: colors,
                                              background: background(),
                                              speed: speed,
                                              animate: animate))
            .mask(self)
    }
}

extension Shape {
    /// Fill a shape with a gradient.
    ///
    /// - Parameters:
    ///   - colors: The colors of the blobs in the gradient.
    ///   - background: The background view of the gradient.
    ///   - speed: The speed at which the blobs move, if they're moving.
    ///   - animate: Whether or not the blobs should move.
    func irregularGradient<Background: View>(colors: [Color],
                                             background: @autoclosure @escaping () -> Background,
                                             speed: Double = 1,
                                             animate: Bool = true) -> some View {
        return self.overlay(IrregularGradient(colors: colors,
                                              background: background(),
                                              speed: speed,
                                              animate: animate))
        .clipShape(self)
    }
}
