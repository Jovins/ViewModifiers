import SwiftUI

struct OnVisibleLayerViewRepresentation: UIViewRepresentable {

    let onDraw: @MainActor () -> Void

    func makeUIView(context: Context) -> some OnVisibleLayerView {
        let view = OnVisibleLayerView()
        view.setOnDraw(onDraw)
        return view
    }
    
    func updateUIView(_ uiView: UIViewType, context: Context) {
        uiView.setOnDraw(onDraw)
    }
}

final class OnVisibleLayerView: UIView {
    
    override class var layerClass: AnyClass {
        OnVisibleLayer.self
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setup()
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    private func setup() {
        isOpaque = false
        backgroundColor = .clear
        if let layer = layer as? OnVisibleLayer {
            layer.drawsAsynchronously = true
        }
    }
    
    override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
        let view = super.hitTest(point, with: event)
        return view == self ? nil : view
    }
    
    func setOnDraw(_ closure: @escaping @MainActor () -> Void) {
        if let layer = layer as? OnVisibleLayer {
            layer.onDraw = closure
        }
    }
}

final class OnVisibleLayer: CATiledLayer {
    var onDraw: @MainActor () -> Void = {}
    override class func fadeDuration() -> CFTimeInterval {
        return 0
    }
    
    override func draw(in ctx: CGContext) {
        if Thread.isMainThread {
            MainActor.assumeIsolated { [onDraw] in
                onDraw()
            }
        } else {
            DispatchQueue.main.async(execute: onDraw)
        }
    }
}

#Preview("List") {
    
  struct _Book: View {
    
    @State var trigger = OnVisibleTrigger()
    
    var body: some View {
      List {
        ForEach(0..<100) { i in
          Text("Item \(i)")
            .onVisible {
              print("Item \(i) is visible")
            }
        }
        Text("Hello, World!")
          .onVisible {
            print("Visble")
          }
      }
    }
  }
  
  return _Book()
}
