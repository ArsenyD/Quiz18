import SwiftUI

struct MainView: View {
    @StateObject var router = Router()
    @StateObject var resourceHandler = ResourceHandler()
    
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
            }
            .navigationDestination(for: [Game].self) { games in
                GameHistoryView(games: games)
            }
            .navigationDestination(for: Game.self) { game in
                GameResultView(for: game)
                    .navigationBarBackButtonHidden(true)
                    .environmentObject(router)
                    .environmentObject(resourceHandler)
            }
        }
    }
    
    func startGame() {
        guard let questions = resourceHandler.loadResource(ofType: [Question].self, from: ResourceHandler.questionsResource.resourceName) else {
            fatalError("Unable to load questions resource.")
        }
        
        let easy = questions.filter { $0.difficulty == .easy }.shuffled().prefix(5)
        let medium = questions.filter { $0.difficulty == .medium }.shuffled().prefix(5)
        let hard = questions.filter { $0.difficulty == .hard }.shuffled().prefix(5)
        let hardcore = questions.filter { $0.difficulty == .hardcore }.shuffled().prefix(3)
        
        let preparedQuestions = Array(easy + medium + hard + hardcore)
        
        router.prepareGame(with: preparedQuestions)
    }
    
    func showGameHistory() {
        var gameHistory: [Game] = []
        
        if let loadedGames = resourceHandler.loadResource(ofType: [Game].self, from: ResourceHandler.gameHistoryResource.resourceName) {
            gameHistory = loadedGames
        }
        
        router.prepareGameHistory(with: gameHistory)
    }
}

#Preview {
    MainView()
}
