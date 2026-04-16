import SwiftUI
import Combine

struct QuestionTimerView: View {
    
    // MARK: Properties
    var timeRemaining: Int
    var progress: Double {
        Double(timeRemaining) / Double(18)
    }
        
    @State private var isFlashing = false
    var isLowTime: Bool {
        timeRemaining <= 5
    }
    
    // MARK: Body
    var body: some View {
        ZStack {
            backgroundRing
            
            foregroundRing
            
            QuestionTimerTickMarksView()
            
            timerLabel
        }
        .frame(width: 220, height: 220)
        .background(Color.black)
        .animation(.linear, value: timeRemaining)
        .onChange(of: timeRemaining) { newValue in
            if newValue <= 5 {
                startFlashing()
            }
        }
    }
    
    // MARK: Components
    var backgroundRing: some View {
        Circle()
            .stroke(isLowTime ? Color.red.opacity(0.2) : Color.purple.opacity(0.1), lineWidth: 10)
    }
    
    var foregroundRing: some View {
        Circle()
            .trim(from: 0, to: progress)
            .stroke(
                isLowTime ? Color.red : Color.purple,
                style: StrokeStyle(lineWidth: 12, lineCap: .round)
            )
            .rotationEffect(.degrees(-90))
            .opacity(isLowTime && isFlashing ? 0.7 : 1.0)
    }
    
    var timerLabel: some View {
        Text("\(timeRemaining)")
            .font(.system(size: 64, weight: .heavy, design: .monospaced))
            .foregroundColor(isLowTime ? .red : .white)
            .contentTransition(.numericText(countsDown: true))
            .shadow(color: isLowTime ? .red : .purple, radius: 40)
            .shadow(color: isLowTime ? .red : .purple, radius: 70)
    }
    
    // MARK: Methods
    private func startFlashing() {
        withAnimation(.easeInOut(duration: 0.5).repeatForever(autoreverses: true)) {
            isFlashing = true
        }
    }
}
