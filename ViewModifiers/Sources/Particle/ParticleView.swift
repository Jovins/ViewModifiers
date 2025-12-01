import SwiftUI

struct ParticleView: View {
    let yaw: Double
    let pitch: Double

    @State private var points = (0...1000).map { _ in Particle.random() }

    var body: some View {
        TimelineView(.animation) { timeline in
            let points = points
            let time = timeline.date.timeIntervalSinceReferenceDate
            
            Canvas { context, size in
                for index in 0..<points.count {
                    let point = points[index]
                    point.draw(context: context, size: size, index: index, time: time, yaw: yaw, pitch: pitch)
                }
            }
        }
    }
}


