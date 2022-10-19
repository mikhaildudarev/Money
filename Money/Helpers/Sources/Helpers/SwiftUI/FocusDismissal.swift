import SwiftUI

struct FocusDismissalViewModifier<FocusableElement: Hashable>: ViewModifier {
    private var binding: FocusState<FocusableElement?>.Binding
    
    init(binding: FocusState<FocusableElement?>.Binding) {
        self.binding = binding
    }
    
    func body(content: Content) -> some View {
        content
            .background {
                Color.clear
                    .contentShape(Rectangle())
                    .ignoresSafeArea()
                    .onTapGesture {
                        binding.wrappedValue = nil
                    }
            }
    }
}

public extension View {
    func dismissingFocusOnTapAround(binding: FocusState<(some Hashable)?>.Binding) -> some View {
        modifier(FocusDismissalViewModifier(binding: binding))
    }
}
