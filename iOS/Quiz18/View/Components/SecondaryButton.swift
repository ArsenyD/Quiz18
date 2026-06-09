import SwiftUI

struct SecondaryButton: View {
    @State private var isPressed = false
    
    var title: LocalizedStringKey
    var action: () -> Void

    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .font(.headline)
                .foregroundStyle(Color.purple)
                .frame(maxWidth: .infinity)
                .frame(height: 50)
                .background(
                    RoundedRectangle(cornerRadius: 14)
                        .fill(Color.purple.opacity(0.08))
                )
                .overlay(
                    RoundedRectangle(cornerRadius: 14)
                        .stroke(Color.purple.opacity(0.25), lineWidth: 1)
                )
                .scaleEffect(isPressed ? 0.98 : 1.0)
        }
        .buttonStyle(.plain)
        .animation(.easeInOut(duration: 0.15), value: isPressed)
        .simultaneousGesture(
            DragGesture(minimumDistance: 0)
                .onChanged { _ in isPressed = true }
                .onEnded { _ in isPressed = false }
        )
    }
    
    init(_ title: LocalizedStringKey, action: @escaping () -> Void) {
        self.title = title
        self.action = action
    }
}

#Preview {
    SecondaryButton("Statistics") {}
}
