import SwiftUI
import Combine

extension IrregularGradient where Background == Color {
    init(colors: [Color],
         backgroundColor: Color = .clear,
         speed: Double = 1,
         animate: Bool = true) {
        self.init(colors: colors,
                  background: backgroundColor,
                  speed: speed,
                  animate: animate)
    }
}

struct IrregularGradient<Background: View>: View {
    
    @State var blobs: [IrregularGradientBlob]
    var background: Background
    var speed: Double
    var animate: Bool
    private let timer: Publishers.Autoconnect<Timer.TimerPublisher>
    private var animation: Animation {
        .spring(response: 3.0/speed, blendDuration: 1.0/speed)
    }

    init(colors: [Color],
         background: @autoclosure @escaping () -> Background,
         speed: Double = 1,
         animate: Bool = true) {
        self._blobs = State(initialValue: colors.map({ IrregularGradientBlob(color: $0) }))
        self.background = background()
        self.speed = speed
        self.animate = animate
        assert(self.speed > 0, "Speed should be greater than zero.")
        let interval = 1.0/self.speed
        self.timer = Timer.publish(every: interval, on: .main, in: .common).autoconnect()
    }

    var body: some View {
        GeometryReader { geometry in
            ZStack {
                background
                ZStack {
                    ForEach(blobs) { blob in
                        IrregularGradientBlobView(blob: blob, geometry: geometry)
                    }
                    .compositingGroup()
                    .blur(radius: pow(min(geometry.size.width, geometry.size.height), 0.65))
                }
            }
            .clipped()
        }
        .onAppear(perform: update)
        .onReceive(timer) { _ in
            update()
        }
        .animation(animation, value: blobs)
    }

    func update() {
        guard animate else { return }
        for index in blobs.indices {
            blobs[index].position = IrregularGradientBlob.makePosition()
            blobs[index].scale = IrregularGradientBlob.makeScale()
            blobs[index].opacity = IrregularGradientBlob.makeOpacity()
        }
    }
}

struct IrregularGradientBlob: Identifiable, Equatable {

    let id = UUID()
    let color: Color

    var position: CGPoint = IrregularGradientBlob.makePosition()
    var scale: CGSize = IrregularGradientBlob.makeScale()
    var opacity: CGFloat = IrregularGradientBlob.makeOpacity()

    static func makePosition() -> CGPoint {
        return CGPoint(x: CGFloat.random(in: 0...1),
                       y: CGFloat.random(in: 0...1))
    }
    
    static func makeScale() -> CGSize {
        return CGSize(width: CGFloat.random(in: 0.25...1),
                      height: CGFloat.random(in: 0.25...1))
    }
    
    static func makeOpacity() -> CGFloat {
        return CGFloat.random(in: 0.75...1)
    }
}

struct IrregularGradientBlobView: View {
    
    var blob: IrregularGradientBlob
    var geometry: GeometryProxy
    
    private var transformedPosition: CGPoint {
        let transform = CGAffineTransform(scaleX: geometry.size.width, y: geometry.size.height)
        return blob.position.applying(transform)
    }

    var body: some View {
        Ellipse()
            .foregroundColor(blob.color)
            .position(transformedPosition)
            .scaleEffect(blob.scale)
            .opacity(blob.opacity)
    }
}

struct IrregularGradient_Previews: PreviewProvider {
    static var previews: some View {
        PreviewWrapper()
    }
    
    struct PreviewWrapper: View {
        @State var animate = true
        
        var body: some View {
            VStack {
                RoundedRectangle(cornerRadius: 30.0, style: .continuous)
                    .irregularGradient(colors: [.orange, .pink, .yellow, .orange, .pink, .yellow],
                                       background: Color.orange,
                                       animate: animate)
                Toggle("Animate", isOn: $animate)
                    .padding()
            }
            .padding(25)
        }
    }
}
