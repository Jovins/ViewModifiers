import SwiftUI

struct Particle {
    var x: Double
    var y: Double
    var z: Double
    var size: Double
    var opacity: Double
    var wiggleAmount: Double
    var wiggleSpeed: Double
    var color: Color
    
    static func random() -> Particle {
        let theta = Double.random(in: -Double.pi...Double.pi)
        let phi = Double.random(in: -Double.pi...Double.pi)
        let distance = Double.random(in: 0.3...0.8)
        return Particle(x: sin(theta) * cos(phi) * distance,
                        y: sin(theta) * sin(phi) * distance,
                        z: cos(theta) * distance,
                        size: Double.random(in: 2...16),
                        opacity: Double.random(in: 0.4...1),
                        wiggleAmount: Double.random(in: 0.01...0.2),
                        wiggleSpeed: Double.random(in: 0.01...0.2),
                        color: Color.softRandom)
    }
    
    func draw(
            context: GraphicsContext,
            size: CGSize,
            index: Int,
            time: Double,
            yaw: Double,
            pitch: Double
        ) {
            // yaw
            let x1 = cos(yaw) * x + sin(yaw) * z
            let y1 = y
            let z1 = -sin(yaw) * x + cos(yaw) * z

            // pitch
            var x2 = x1
            var y2 = cos(pitch) * y1 - sin(pitch) * z1
            var z2 = sin(pitch) * y1 + cos(pitch) * z1

            let offset = time * wiggleSpeed + Double(index)

            x2 += sin(offset) * wiggleAmount
            y2 += cos(offset) * wiggleAmount
            z2 += cos(offset) * wiggleAmount

            let particleSize = self.size + z2

            let rect = CGRect(
                origin: CGPoint(
                    x: (x2 + 1) / 2 * size.width - particleSize / 2,
                    y: (y2 + 1) / 2 * size.height - particleSize / 2
                ),
                size: CGSize(width: particleSize, height: particleSize)
            )

            let opacity2 = opacity * (z2 + 1) / 2

            let drawColor: Color = color.opacity(opacity2)
            context.fill(Circle().path(in: rect), with: .color(drawColor))
        }
}

extension Color {
    static var softRandom: Color {
        let hue = Double.random(in: 0...1)
        let saturation = Double.random(in: 0.3...0.6)
        let brightness = Double.random(in: 0.85...1.0)
        return Color(hue: hue, saturation: saturation, brightness: brightness)
    }
}
