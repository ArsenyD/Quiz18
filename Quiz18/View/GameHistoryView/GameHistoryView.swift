import SwiftUI

struct GameHistoryView: View {
    var games: [Game]
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(games) { game in
                    GameHistoryRowView(game: game)
                }
            }
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Game History")
        .navigationBarTitleDisplayMode(.large)
    }
}



#Preview {
    let gameHistory: [Game] = {
        let calendar = Calendar.current
        let now = Date()
        
        return [
            Game(
                date: now,
                rightAnswersAmount: 8
            ),
            Game(
                date: calendar.date(byAdding: .day, value: -1, to: now)!,
                rightAnswersAmount: 5
            ),
            Game(
                date: calendar.date(byAdding: .day, value: -2, to: now)!,
                rightAnswersAmount: 10
            ),
            Game(
                date: calendar.date(byAdding: .day, value: -3, to: now)!,
                rightAnswersAmount: 7
            ),
            Game(
                date: calendar.date(byAdding: .day, value: -4, to: now)!,
                rightAnswersAmount: 3
            ),
            Game(
                date: calendar.date(byAdding: .day, value: -5, to: now)!,
                rightAnswersAmount: 9
            ),
            Game(
                date: calendar.date(byAdding: .day, value: -6, to: now)!,
                rightAnswersAmount: 6
            )
        ]
    }()
    
    
    return GameHistoryView(games: gameHistory)
}
