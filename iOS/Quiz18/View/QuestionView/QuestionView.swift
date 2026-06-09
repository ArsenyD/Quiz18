import SwiftUI
import Combine

struct QuestionView: View {
    // MARK: Properties
    @EnvironmentObject var router: Router
    @EnvironmentObject var gameEngine: GameEngine
    @State var question: Question
    @State private var selectedOption: Question.QuestionOption?
    
    @State var timeRemaining: Int = 18
    @State private var isTimerExpired = false
    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    // MARK: Layout
    private enum Constants {
        static let buttonSpacing: CGFloat = 10
        static let verticalSpacing: CGFloat = 50
    }
    
    let columns = [
        GridItem(.flexible(), spacing: Constants.buttonSpacing),
        GridItem(.flexible(), spacing: Constants.buttonSpacing)
    ]
    
    // MARK: Body
    var body: some View {
        VStack(spacing: Constants.verticalSpacing) {
            questionDescriptionLabel
            
            Spacer()
            
            QuestionTimerView(timeRemaining: timeRemaining)
            
            Spacer()
            Spacer()
            
            optionButtons
                .padding([.horizontal, .bottom])
        }
        .frame(minHeight: 0, maxHeight: .infinity)
        .navigationTitle(
            String.localizedStringWithFormat(
                String(localized: "question_number"),
                gameEngine.currentQuestionIndex + 1
            )
        )
        .navigationBarTitleDisplayMode(.inline)
        .onReceive(timer) { _ in
            onTimerPublishedValueAction()
        }
        .onChange(of: isTimerExpired) { isTimerExpired in
            if isTimerExpired {
                endGame()
            }
        }
    }
    
    // MARK: Components
    var questionDescriptionLabel: some View {
        Text(question.description)
            .bold()
            .font(.title)
    }
    
    var optionButtons: some View {
        LazyVGrid(columns: columns, spacing: Constants.buttonSpacing) {
            ForEach(question.options) { option in
                QuestionButton(for: option, selectedOption: $selectedOption) {
                    questionButtonAction()
                }
                .disabled(timeRemaining == 0)
            }
        }
    }
    
    // MARK: Methods
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
    
    private func onTimerPublishedValueAction() {
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
