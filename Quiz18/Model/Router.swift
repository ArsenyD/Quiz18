import Foundation
import SwiftUI
import Combine

class Router: ObservableObject {
    @Published var path = NavigationPath()
    @Published var gameQuestions: [Question] = []
    @Published private var ongoingGameState: GameBuilder?
    
    func prepareGame(with questions: [Question]) {
        ongoingGameState = GameBuilder()
        
        gameQuestions = questions.reversed()
        
        path.append(gameQuestions.removeLast())
    }
    
    func prepareGameHistory(with games: [Game]) {
        path.append(games)
    }
    
    func navigateToNextQuestion() {
        guard !gameQuestions.isEmpty else {
            endGame()
            
            return
        }
        
        guard let ongoingGameState else { fatalError("Invalid game state") }
        
        ongoingGameState.incrementRightAnswers()
        path.append(gameQuestions.removeLast())
    }
    
    func endGame() {
        guard let finishedGame = ongoingGameState?.build() else { fatalError("Invalid game state") }
        ongoingGameState = nil
        
        path.append(finishedGame)
    }
    
    func navigateToMain() {
        path = NavigationPath()
    }
}
