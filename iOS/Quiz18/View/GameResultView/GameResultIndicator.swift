import SwiftUI

struct GameResultIndicator: View {
    @State private var value: Int = 0
    var result: Int
    
    enum Constants {
        static let indicatorLineWidth: CGFloat = 20
        static let barEndProtrusion: CGFloat = 8
    }
    

    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0, to: CGFloat(Double(value) / 18))
                .stroke(
                    calculateLabelColor(),
                    style: StrokeStyle(lineWidth: Constants.indicatorLineWidth, lineCap: .round)
                )
                .foregroundStyle(.white)
                .rotationEffect(.degrees(-90))
            
            Circle()
                .stroke(
                    calculateLabelColor().opacity(0.3),
                    style: StrokeStyle(lineWidth: Constants.indicatorLineWidth, lineCap: .round)
                )
                .foregroundStyle(.white)
                .rotationEffect(.degrees(-90))
            
            VStack(spacing: 40) {
                HStack {
                    if #available(iOS 26, *) {
                        Text("\(value)")
                            .font(.system(size: 64, weight: .heavy, design: .monospaced))
                            .contentTransition(.numericText(value: Double(value)))
                            .foregroundColor(calculateLabelColor())
                    }
                    
                    Text("/18")
                        .font(.system(size: 32, weight: .heavy, design: .monospaced))
                        .foregroundStyle(.secondary)
                }
            }
        }
        .padding(.horizontal, 50)
        .onAppear {
            withAnimation() {
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

struct BarEnd: View {
    var body: some View {
        Circle()
            .foregroundStyle(.white)
    }
}

#Preview {
    GameResultIndicator(result: 3)
}
