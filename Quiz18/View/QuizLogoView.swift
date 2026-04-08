import SwiftUI

struct QuizLogoView: View {
    var body: some View {
        HStack(spacing: 14) {
            ClockView()
            
            Text("18")
                .font(.system(size: 84, weight: .heavy, design: .monospaced))
                .foregroundStyle(Color.purple)
        }
    }
}

struct ClockView: View {
    var body: some View {
        ZStack {
            Circle()
                .trim(from: 0.0, to: 0.92)
                .stroke(Color.purple, lineWidth: 6)
                .rotationEffect(.degrees(90))
                .frame(width: 70, height: 70)
            
            
            ForEach(0..<12) { i in
                Rectangle()
                    .fill(Color.purple)
                    .frame(width: 2.5, height: i % 3 == 0 ? 10 : 6)
                    .offset(y: -28)
                    .rotationEffect(.degrees(Double(i) * 30))
            }
            
            Rectangle()
                .fill(Color.purple)
                .frame(width: 3, height: 20)
                .offset(y: -10)
        }
        .frame(width: 80, height: 80)
    }
}

#Preview {
    QuizLogoView()
}
