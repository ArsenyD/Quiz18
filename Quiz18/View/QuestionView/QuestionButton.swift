import SwiftUI

struct QuestionButton: View {
    @EnvironmentObject private var router: Router
    @Binding var question: Question
    var option: Question.QuestionOption
    
    var body: some View {
        Button(option.description) {
            withAnimation(.bouncy) {
                chooseOption()
            }
        }
        .frame(height: 50)
        .frame(minWidth: 0, maxWidth: .infinity)
        .background(calculateColor(), in: RoundedRectangle(cornerRadius: 8))
        .foregroundStyle(.primary)
        .bold()
    }
    
    func chooseOption() {
        guard question.chosenOption == nil else { return }
        
        question.chosenOption = option
        
        Task {
            if option.isCorrect {
                try? await Task.sleep(nanoseconds: 0_500_000_000)
                router.navigateToNextQuestion()
            } else {
                try? await Task.sleep(nanoseconds: 1_000_000_000)
                router.endGame()
            }
        }
    }
    
    func calculateColor() -> Color {
        guard let chosen = question.chosenOption else {
            return .purple
        }
        
        if option.isCorrect {
            return .green
        }
        
        if chosen.description == option.description {
            return chosen.isCorrect ? .green : .red
        }
        
        return .purple.opacity(0.4)
    }
    
    init(for question: Binding<Question>, option: Question.QuestionOption) {
        self._question = question
        self.option = option
    }
}
