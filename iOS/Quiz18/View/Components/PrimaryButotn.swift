import SwiftUI

struct PrimaryButton: View {
    @State private var isPressed = false
    
    let title: LocalizedStringKey
    let action: () -> Void
    
    var body: some View {
        Button {
            action()
        } label: {
            Text(title)
                .font(.headline)
                .bold()
                .foregroundStyle(.white)
                .frame(maxWidth: .infinity)
                .frame(height: 54)
                .background(
                    ZStack {
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.purple)
                            .blur(radius: isPressed ? 4 : 7)
                            .opacity(isPressed ? 0.6 : 0.9)
                        
                        RoundedRectangle(cornerRadius: 16)
                            .fill(Color.purple)
                    }
                )
                .scaleEffect(isPressed ? 0.97 : 1.0)
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
    PrimaryButton("Play") {}
        .padding()
}
