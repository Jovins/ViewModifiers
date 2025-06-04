import SwiftUI

extension View {
    func onVisible(_ handler: @escaping () -> Void) -> some View {
        modifier(OnVisibleWrapperModifier(onVisible: handler))
    }
}
