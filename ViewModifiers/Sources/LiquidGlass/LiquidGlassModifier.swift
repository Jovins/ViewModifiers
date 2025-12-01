import SwiftUI

struct LiquidGlassModifier: ViewModifier {
    let cornerRadius: CGFloat
    let updateMode: SnapshotUpdateMode
    let blurScale: CGFloat
    
    @State var size: CGSize = .zero

    public func body(content: Content) -> some View {
        content
            .background(LiquidGlassView(cornerRadius: cornerRadius, updateMode: updateMode, blurScale: blurScale))
    }
}

extension View {
    func liquidGlass(
        cornerRadius: CGFloat = 20,
        updateMode: SnapshotUpdateMode = .continuous(),
        blurScale: CGFloat = 0.5
    ) -> some View {
        modifier(LiquidGlassModifier(cornerRadius: cornerRadius, updateMode: updateMode, blurScale: blurScale))
    }
}

#if DEBUG
struct AnimatedGradientBackground: View {
    @State private var animate = false

    var body: some View {
        LinearGradient(gradient: Gradient(colors: [.blue, .purple, .pink]),
                       startPoint: animate ? .topLeading : .bottomTrailing,
                       endPoint: animate ? .bottomTrailing : .topLeading)
            .ignoresSafeArea()
            .onAppear {
                withAnimation(Animation.linear(duration: 5).repeatForever(autoreverses: true)) {
                    animate.toggle()
                }
            }
    }
}

#Preview {
    ZStack {
        AnimatedGradientBackground()
        VStack(spacing: 20) {
            Text("Liquid Glass Button")
                .font(.title)
                .foregroundColor(.white)
            
            Button("Click Me") {
                print("Tapped")
            }
            .font(.headline)
            .padding()
            .liquidGlass(cornerRadius: 60)
        }
    }
}
#endif
