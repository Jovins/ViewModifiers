import SwiftUI

struct CompatibilityModifier: ViewModifier {
    var radius: CGFloat
    var offset: CGFloat
    var distance: CGFloat
    var direction: BlurDirection
    
    var gradientMask: some View {
        var (startPoint, endPoint) = direction.unitPoints
        return LinearGradient(stops: [Gradient.Stop(color: .clear, location: 0),
                                      Gradient.Stop(color: .clear, location: offset),
                                      Gradient.Stop(color: .black, location: offset + distance)],
                              startPoint: startPoint,
                              endPoint: endPoint)
    }

    func body(content: Content) -> some View {
        content
            .overlay {
                content
                    .drawingGroup()
                    .allowsHitTesting(false)
                    .blur(radius: radius)
                    .scaleEffect(1 + (radius * 0.02))
                    .mask(gradientMask)
            }
    }
}
