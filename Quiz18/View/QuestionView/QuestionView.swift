import SwiftUI
import Combine

struct QuestionView: View {
    @EnvironmentObject var router: Router
    @EnvironmentObject var gameEngine: GameEngine
    @State var question: Question
    @State private var selectedOption: Question.QuestionOption?
    @State var timeRemaining: Int = 18
    @State private var isTimerExpired = false

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    private enum Constants {
        static let buttonSpacing: CGFloat = 10
        static let verticalSpacing: CGFloat = 50
    }
    
    let columns = [
        GridItem(.flexible(), spacing: Constants.buttonSpacing),
        GridItem(.flexible(), spacing: Constants.buttonSpacing)
    ]
    
    var body: some View {
        VStack(spacing: Constants.verticalSpacing) {
            Text(question.description)
                .bold()
                .font(.title)
            
            QuestionTimerView(timeRemaining: timeRemaining)
            
            LazyVGrid(columns: columns, spacing: Constants.buttonSpacing) {
                ForEach(question.options) { option in
                    QuestionButton(for: option, selectedOption: $selectedOption) {
                        questionButtonAction()
                    }
                    .disabled(timeRemaining == 0)
                }
            }
        }
        .onReceive(timer) { elapsed in
            guard timeRemaining > 0  else {
                timer.upstream.connect().cancel()
                isTimerExpired = true
                return
            }
            
            guard selectedOption == nil else {
                timer.upstream.connect().cancel()
                return
            }
            
            timeRemaining -= 1
        }
        .onChange(of: isTimerExpired) { isTimerExpired in
            if isTimerExpired {
                endGame()
            }
        }
    }
    
    private func questionButtonAction() {
        guard let selectedOption else { return }
        
        Task {
            if selectedOption.isCorrect {
                try? await Task.sleep(nanoseconds: 0_500_000_000)
                nextQuestion()
            } else {
                try? await Task.sleep(nanoseconds: 1_000_000_000)
                endGame()
            }
        }
    }
    
    private func nextQuestion() {
        guard let nextQuestion = gameEngine.nextQuestion() else {
            endGame()
            return
        }
        
        router.nextQuestion(nextQuestion)
    }
    
    private func endGame() {
        let game = gameEngine.endGame()
        router.endGame(game)
    }
}
