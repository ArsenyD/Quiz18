import SwiftUI

struct GameResultIndicator: View {
    
    // MARK: Properties
    @State private var value: Int = 0
    var result: Int
    
    private enum Constants {
        static let indicatorLineWidth: CGFloat = 20
        static let barBackgroundOpacity: CGFloat = 0.3
        static let labelFontSize: CGFloat = 64
        static let horizontalPadding: CGFloat = 50
    }
    
    // MARK: Body
    var body: some View {
        ZStack {
            foregroundRing
            
            backgroundRing
            
            indicatorLabel
        }
        .padding(.horizontal, Constants.horizontalPadding)
        .onAppear {
            withAnimation(.easeOut(duration: 0.7)) {
                value = result
            }
        }
    }
    
    // MARK: Components
    var foregroundRing: some View {
        Circle()
            .trim(from: 0, to: CGFloat(Double(value) / 18))
            .stroke(
                calculateIndicatorColor(),
                style: StrokeStyle(lineWidth: Constants.indicatorLineWidth, lineCap: .round)
            )
            .rotationEffect(.degrees(-90))
    }

    
    var backgroundRing: some View {
        Circle()
            .stroke(
                calculateIndicatorColor().opacity(Constants.barBackgroundOpacity),
                style: .init(lineWidth: Constants.indicatorLineWidth)
            )
            .rotationEffect(.degrees(-90))
    }
    
    var indicatorLabel: some View {
        HStack {
            Text("\(value)")
                .font(.system(size: Constants.labelFontSize, weight: .heavy, design: .monospaced))
                .contentTransition(.numericText())
                .foregroundColor(calculateIndicatorColor())
            
            Text("/18")
                .font(.system(size: Constants.labelFontSize / 2, weight: .heavy, design: .monospaced))
                .foregroundStyle(.secondary)
        }
    }
    
    // MARK: Methods
    private func calculateIndicatorColor() -> Color {
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
