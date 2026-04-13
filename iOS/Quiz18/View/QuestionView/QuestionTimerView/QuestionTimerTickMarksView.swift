import SwiftUI

struct QuestionTimerTickMarksView: View {
    let ticks = 60
    let ticksInset: CGFloat = 5
    
    var body: some View {
        ZStack {
            ForEach(0..<ticks, id: \.self) { i in
                Rectangle()
                    .fill(Color.white.opacity(i % 5 == 0 ? 0.8 : 0.3))
                    .frame(width: 2, height: i % 5 == 0 ? 10 : 5)
                    .offset(y: -100 + ticksInset)
                    .rotationEffect(.degrees(Double(i) / Double(ticks) * 360))
            }
        }
    }
}
