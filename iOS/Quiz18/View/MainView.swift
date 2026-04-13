import SwiftUI

struct MainView: View {
    @StateObject var router = Router()
    @StateObject var gameEngine = GameEngine()
    let resourceHandler = ResourceHandler()
    
    var body: some View {
        NavigationStack(path: $router.path) {
            VStack(spacing: 30) {
                Spacer()
                
                QuizLogoView()
                    .padding(.bottom, 50)
                
                PrimaryButton("Play") {
                    startGame()
                }
                
                SecondaryButton("Statistics") {
                    showGameHistory()
                }
                
                Spacer()
            }
            .padding(.horizontal)
            .navigationDestination(for: Question.self) { question in
                QuestionView(question: question)
                    .navigationBarBackButtonHidden(true)
                    .environmentObject(router)
                    .environmentObject(gameEngine)
            }
            .navigationDestination(for: [Game].self) { games in
                GameHistoryView(games: games)
            }
            .navigationDestination(for: Game.self) { game in
                GameResultView(for: game)
                    .navigationBarBackButtonHidden(true)
                    .environmentObject(router)
                    .environmentObject(gameEngine)
            }
        }
    }
    
    private func startGame() {
        let firstQuestion = gameEngine.prepareGame()
        router.startGame(with: firstQuestion)
    }
    
    private func showGameHistory() {
        var games: [Game] = []
        
        if let loadedGames = resourceHandler.loadResource(ofType: [Game].self, from: Resource.gameHistory) {
            games = loadedGames
        }
        
        router.showGameHistory(games)
    }
}

#Preview {
    MainView()
}
