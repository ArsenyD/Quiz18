import Foundation
import SwiftUI
import Combine

class Router: ObservableObject {
    @Published var path = NavigationPath()
    
    public func startGame(with question: Question) {
        path.append(question)
    }
    
    public func nextQuestion(_ question: Question) {
        path.append(question)
    }
    
    public func endGame(_ game: Game) {
        path.append(game)
    }
    
    public func showGameHistory(_ games: [Game]) {
        path.append(games)
    }
    
    public func navigateToMain() {
        path = NavigationPath()
    }
}
