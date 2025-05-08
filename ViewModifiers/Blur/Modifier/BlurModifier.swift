import SwiftUI

@available(iOS 17.0, macOS 14.0, watchOS 10.0, tvOS 17.0, visionOS 1.0, *)
struct BlurModifier: ViewModifier {
    var radius: CGFloat
    var offset: CGFloat
    var distance: CGFloat
    var direction: BlurDirection
    
    @Environment(\.displayScale) var displayScale
    
    private let library = ShaderLibrary.default

    var blurX: Shader {
        var shader = library.blurX(.float(radius),
                                   .float(offset),
                                   .float(distance),
                                   .float(Float(direction.rawValue)),
                                   .float(displayScale))
        shader.dithersColor = true
        return shader
    }

    var blurY: Shader {
        var shader = library.blurY(.float(radius),
                                   .float(offset),
                                   .float(distance),
                                   .float(Float(direction.rawValue)),
                                   .float(displayScale))
        shader.dithersColor = true
        return shader
    }
    
    func body(content: Content) -> some View {
        content
            .drawingGroup()
            .layerEffect(blurX, maxSampleOffset: .zero)
            .layerEffect(blurY, maxSampleOffset: .zero)
    }
}
