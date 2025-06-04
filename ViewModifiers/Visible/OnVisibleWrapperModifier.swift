import SwiftUI

struct OnVisibleWrapperModifier: ViewModifier {

    private let onVisible: () -> Void
    @State private var trigger = OnVisibleTrigger()

    init(onVisible: @escaping () -> Void) {
        self.onVisible = onVisible
    }
    
    func body(content: Content) -> some View {
        content
            .modifier(OnVisibleModifier(trigger: $trigger))
            .onChange(of: trigger, {
                onVisible()
            })
    }
}
