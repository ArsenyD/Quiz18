import SwiftUI

struct GameResultIndicator: View {
    @State private var value: Int = 0
    var result: Int
    
    enum Constants {
        static let indicatorLineWidth: CGFloat = 20
        static let barBackgroundOpacity: CGFloat = 0.3
        static let labelFontSize: CGFloat = 64
        static let horizontalPadding: CGFloat = 50
    }
    
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: CGFloat(Double(value) / 18))
                .stroke(
                    calculateLabelColor(),
                    style: StrokeStyle(lineWidth: Constants.indicatorLineWidth, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
            
            Circle()
                .stroke(
                    calculateLabelColor().opacity(Constants.barBackgroundOpacity),
                    style: .init(lineWidth: Constants.indicatorLineWidth)
                )
                .rotationEffect(.degrees(-90))
            
            VStack(spacing: 40) {
                HStack {
                    Text("\(value)")
                        .font(.system(size: Constants.labelFontSize, weight: .heavy, design: .monospaced))
                        .contentTransition(.numericText())
                        .foregroundColor(calculateLabelColor())
                    
                    Text("/18")
                        .font(.system(size: Constants.labelFontSize / 2, weight: .heavy, design: .monospaced))
                        .foregroundStyle(.secondary)
                }
            }
        }
        .padding(.horizontal, Constants.horizontalPadding)
        .onAppear {
            withAnimation(.easeOut(duration: 0.7)) {
                value = result
            }
        }
    }
    
    private func calculateLabelColor() -> Color {
        let ratio = Double(value) / 18.0
        
        switch ratio {
        case 0..<0.4:
            return .red
        case 0.4..<0.7:
            return .orange
        case 0.7..<0.9:
            return .yellow
        default:
            return .green
        }
    }
}


#Preview {
    GameResultIndicator(result: 8)
}
