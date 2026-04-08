import SwiftUI
import Combine

struct QuestionTimerView: View {
    var timeRemaining: Int
    var progress: Double {
        Double(timeRemaining) / Double(18)
    }
        
    @State private var isFlashing = false
    var isLowTime: Bool {
        timeRemaining <= 5
    }
    
    var body: some View {
        ZStack {
            // Background Ring
            Circle()
                .stroke(isLowTime ? Color.red.opacity(0.2) : Color.purple.opacity(0.1), lineWidth: 10)
            
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    isLowTime ? Color.red : Color.purple,
                    style: StrokeStyle(lineWidth: 12, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
                .blur(radius: isLowTime ? 12 : 8)
                .opacity(isLowTime ? 0.9 : 0.6)
                .scaleEffect(isLowTime && isFlashing ? 1.03 : 1.0)
            
            // Progress Ring
            Circle()
                .trim(from: 0, to: progress)
                .stroke(
                    isLowTime ? Color.red : Color.purple,
                    style: StrokeStyle(lineWidth: 12, lineCap: .round)
                )
                .rotationEffect(.degrees(-90))
                .opacity(isLowTime && isFlashing ? 0.7 : 1.0)
            
            QuestionTimerTickMarksView()
            
            Text("\(timeRemaining)")
                .font(.system(size: 64, weight: .heavy, design: .monospaced))
                .foregroundColor(isLowTime ? .red : .white)
                .contentTransition(.numericText(countsDown: true))
                .shadow(color: isLowTime ? .red : .purple, radius: 40)
                .shadow(color: isLowTime ? .red : .purple, radius: 70)
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
    
    func startFlashing() {
        withAnimation(.easeInOut(duration: 0.5).repeatForever(autoreverses: true)) {
            isFlashing = true
        }
    }
}

struct QuestionTimerPreview: View {
    @State var timeRemaining: Int = 18
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    var body: some View {
        QuestionTimerView(timeRemaining: timeRemaining)
            .onReceive(timer) { elapsed in
                guard timeRemaining > 0 else {
                    timer.upstream.connect().cancel()
                    return
                }
                
                timeRemaining -= 1
            }
    }
}


#Preview {
    QuestionTimerPreview()
}
