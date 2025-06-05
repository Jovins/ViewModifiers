import SwiftUI

struct OnVisibleModifier: ViewModifier {
  
  @Binding var trigger: OnVisibleTrigger
  
  public init(trigger: Binding<OnVisibleTrigger>) {
    self._trigger = trigger
  }

  public func body(content: Content) -> some View {
    content
      .overlay(
        OnVisibleLayerViewRepresentation(onDraw: {
          trigger.send()
        })
        .frame(width: 1, height: 1)
        .allowsHitTesting(false)
      )
  }
}
