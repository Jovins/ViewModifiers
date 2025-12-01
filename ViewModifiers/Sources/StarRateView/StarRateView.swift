import SwiftUI

@available(iOS 13.0, *)
struct StarRateView: View {

    // MARK: - Public
    let starCount: Int
    @Binding var rate: Double
    // MARK: - Private
    private var starSize: CGFloat = 32
    private var starPadding: CGFloat = 8.0
    private var backgroundStarColor: Color = .white
    private var borderStarColor: Color = .gray
    private var forgroundStarColor: Color = .yellow
    private var corners: Int = 5
    private var smoothness: CGFloat = 0.45
    private var borderOffset: CGFloat = 0.2
    private var borderWidth: CGFloat = 5

    init(starCount: Int, rate: Binding<Double>) {
        self.starCount = starCount
        self._rate = rate
    }

    var body: some View {
        GeometryReader { geo in
            HStack(alignment: .center, spacing: self.starPadding) {
                ForEach(0..<self.starCount, id: \.self) { index in
                    ZStack(alignment: .center) {
                        StarShape(corners: self.corners, smoothness: self.smoothness)
                            .fill(self.borderStarColor)
                            .frame(width: self.starSize, height: self.starSize)
                        StarShape(corners: self.corners, smoothness: self.smoothness)
                            .fill(self.backgroundStarColor)
                            .frame(width: self.starSize - 5, height: self.starSize - 5)
                            .offset(y: self.borderOffset)
                        StarShape(corners: self.corners, smoothness: self.smoothness)
                            .fill(self.forgroundStarColor)
                            .frame(width: self.starSize, height: self.starSize)
                            .mask(Rectangle().padding(.trailing, self.calculateStarSize(index: index)))
                    }
                }
            }
            .contentShape(Rectangle())
            .gesture(
                DragGesture(minimumDistance: 0)
                    .onChanged { value in
                        let newRate = self.rate(at: value.location, in: geo.size.width)
                        self.rate = newRate
                    }
            )
            .simultaneousGesture(
                // TapGesture 没有 location，忽略
                TapGesture()
                    .onEnded {}
            )
        }
        .frame(height: starSize)
    }
    
    // MARK: - Private Method
    private func calculateStarSize(index: Int) -> CGFloat {
        if Double(index + 1) <= rate {
            return 0
        } else if rate > Double(index) && rate < Double(index + 1) {
            return CGFloat(1 - (rate - Double(index))) * self.starSize
        }
        return self.starSize
    }
    
    private func rate(at location: CGPoint, in totalWidth: CGFloat) -> Double {
        let x = min(max(0, location.x), totalWidth)
        let single = starSize + starPadding
        let raw = x / single
        return min(Double(starCount), max(0, Double(raw)))
    }
}

@available(iOS 13.0, *)
extension StarRateView: Buildable {

    func starSize(_ starSize: CGFloat) -> Self {
        mutating(keyPath: \.starSize, value: starSize)
    }

    func starPadding(_ padding: CGFloat) -> Self {
        mutating(keyPath: \.starPadding, value: padding)
    }

    func forgroundStarColor(_ color: Color) -> Self {
        mutating(keyPath: \.forgroundStarColor, value: color)
    }
    
    func backgroundStarColor(_ color: Color) -> Self {
        mutating(keyPath: \.backgroundStarColor, value: color)
    }
    
    func borderStarColor(_ color: Color) -> Self {
        mutating(keyPath: \.borderStarColor, value: color)
    }
    
    func corners(_ corners: Int) -> Self {
        mutating(keyPath: \.corners, value: corners)
    }
    
    func smoothness(_ smoothness: CGFloat) -> Self {
        mutating(keyPath: \.smoothness, value: smoothness)
    }
    
    func borderOffset(_ offset: CGFloat) -> Self {
        mutating(keyPath: \.borderOffset, value: offset)
    }

    func borderWidth(_ width: CGFloat) -> Self {
        mutating(keyPath: \.borderWidth, value: width)
    }
}

struct StarContentView: View {
    
    @State private var rate: Double = 0.0

    var body: some View {
        VStack(alignment: .center, spacing: 16) {
            Image("sanjin")
                .resizable()
                .frame(width: UIScreen.main.bounds.width,
                       height: UIScreen.main.bounds.width)
            HStack {
                VStack(alignment: .leading, spacing: 8) {
                    Text("Star Rate View")
                        .fontWeight(.semibold)
                        .font(.system(size: 22))
                    StarRateView(starCount: 5, rate: $rate)
                        .starSize(24)
                        .starPadding(4)
                        .corners(5)
                        .forgroundStarColor(.yellow)
                        .backgroundStarColor(.gray)
                }
                Spacer()
            }
            .padding(.leading, 16)
            Slider(value: $rate, in: 0...5, step: 0.1)
                .padding(.horizontal, 16)
            Spacer()
        }
        .ignoresSafeArea(.all)
        Spacer()
    }
}

#Preview {
    StarContentView()
}

