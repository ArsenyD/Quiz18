import SwiftUI

struct GameHistoryRowView: View {
    var game: Game
    
    // MARK: Body
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(game.date.formatted(date: .abbreviated, time: .omitted))
                    .font(.headline)
                
                Text(game.date.formatted(date: .omitted, time: .shortened))
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
            
            Spacer()
            
            VStack(alignment: .trailing, spacing: 4) {
                Text("\(game.rightAnswersAmount)")
                    .font(.title2)
                    .bold()
                    .foregroundStyle(colorForScore())
                
                Text("Correct")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
        .background(
            RoundedRectangle(cornerRadius: 16)
                .fill(Color(.secondarySystemBackground))
        )
    }
    
    // MARK: Methods
    private func colorForScore() -> Color {
        let ratio = Double(game.rightAnswersAmount) / 18.0
        
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
