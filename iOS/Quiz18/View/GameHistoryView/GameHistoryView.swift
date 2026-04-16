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
        .scrollIndicators(.hidden)
        .background(Color(.systemGroupedBackground))
        .navigationTitle("Game History")
        .navigationBarTitleDisplayMode(.large)
    }
}
