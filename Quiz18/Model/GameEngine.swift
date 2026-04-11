import Foundation
import Combine

final class GameEngine: ObservableObject {
    @Published private var gameQuestions: [Question] = []
    @Published private var currentQuestionIndex: Int = 0
    
    private lazy var resourceHandler = ResourceHandler()
    
    public func prepareGame() -> Question {
        guard let questions = resourceHandler.loadResource(ofType: [Question].self, from: Resource.questions) else {
            fatalError("Unable to load questions resource.")
        }
        
        let easy = questions.filter { $0.difficulty == .easy }.shuffled().prefix(5)
        let medium = questions.filter { $0.difficulty == .medium }.shuffled().prefix(5)
        let hard = questions.filter { $0.difficulty == .hard }.shuffled().prefix(5)
        let hardcore = questions.filter { $0.difficulty == .hardcore }.shuffled().prefix(3)
        
        gameQuestions = Array(easy + medium + hard + hardcore)
        currentQuestionIndex = 0
        
        return gameQuestions[currentQuestionIndex]
    }
    
    public func nextQuestion() -> Question? {
        currentQuestionIndex += 1
        
        guard currentQuestionIndex < gameQuestions.count else { return nil }
        
        return gameQuestions[currentQuestionIndex]
    }
    
    public func endGame() -> Game {
        let game = Game(rightAnswersAmount: currentQuestionIndex)
        resourceHandler.saveResource([game], to: Resource.gameHistory)
        
        return game
    }
}
