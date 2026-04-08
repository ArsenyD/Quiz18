import Foundation
import Combine

class GameBuilder: ObservableObject {
    private let date = Date()
    private var rightAnswersAmount = 0
    
    func incrementRightAnswers() {
        rightAnswersAmount += 1
    }
    
    func build() -> Game {
        return Game(date: date, rightAnswersAmount: rightAnswersAmount)
    }
}
