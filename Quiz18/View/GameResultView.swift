import SwiftUI

struct GameResultView: View {
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var resourceHandler: ResourceHandler
    
    let game: Game
    
    var body: some View {
        Spacer()
        
        Text("Right Answers: \(game.rightAnswersAmount)")
        
        Spacer()
        
        PrimaryButton("Play Again") {
            saveGameToHistory()
            startNewGame()
        }
        
        SecondaryButton("Go to menu") {
            saveGameToHistory()
            router.navigateToMain()
        }
        .padding(.bottom)
        .padding(.top, 15)
    }
    
    func saveGameToHistory() {
        resourceHandler.saveResource(game, to: ResourceHandler.gameHistoryResource.resourceName)
    }
    
    func startNewGame() {
        guard let questions = resourceHandler.loadResource(ofType: [Question].self, from: ResourceHandler.questionsResource.resourceName) else {
            fatalError("Unable to load questions")
        }
        
        let easy = questions.filter { $0.difficulty == .easy }.shuffled().prefix(5)
        let medium = questions.filter { $0.difficulty == .medium }.shuffled().prefix(5)
        let hard = questions.filter { $0.difficulty == .hard }.shuffled().prefix(5)
        let hardcore = questions.filter { $0.difficulty == .hardcore }.shuffled().prefix(3)
        
        let preparedQuestions = Array(easy + medium + hard + hardcore)
        
        router.prepareGame(with: preparedQuestions)
    }
    
    init(for game: Game) {
        self.game = game
    }
}
