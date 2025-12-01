import SwiftUI

struct ParticleContentView: View {
    @State private var yaw = 0.0
    @State private var pitch = 0.0

    var body: some View {
        VStack {
            ParticleView(yaw: yaw, pitch: pitch)
                .ignoresSafeArea()
                .aspectRatio(1, contentMode: .fill)

            Slider(value: $yaw, in: -Double.pi...Double.pi).padding(.horizontal)
            Slider(value: $pitch, in: -Double.pi...Double.pi).padding(.horizontal)
        }
        .background(.black)
    }
}

#Preview {
    ParticleContentView()
}
