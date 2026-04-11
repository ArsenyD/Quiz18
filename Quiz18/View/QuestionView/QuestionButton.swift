import SwiftUI

struct QuestionButton: View {
    @Binding var selectedOption: Question.QuestionOption?
    var option: Question.QuestionOption
    var onPressAction: () -> Void
    
    var body: some View {
        Button(option.description) {
            withAnimation(.bouncy) {
                selectOption()
            }
        }
        .frame(height: 50)
        .frame(minWidth: 0, maxWidth: .infinity)
        .background(calculateColor(), in: RoundedRectangle(cornerRadius: 8))
        .foregroundStyle(.primary)
        .bold()
    }
    
    private func selectOption() {
        guard selectedOption == nil else { return }
        
        selectedOption = option
        
        onPressAction()
    }
    
    private func calculateColor() -> Color {
        guard let selectedOption else {
            return .purple
        }
        
        if option.isCorrect {
            return .green
        }
        
        if selectedOption.description == option.description {
            return selectedOption.isCorrect ? .green : .red
        }
        
        return .purple.opacity(0.4)
    }
    
    init(for option: Question.QuestionOption, selectedOption: Binding<Question.QuestionOption?>, _ onPressAction: @escaping () -> Void) {
        self.option = option
        self.onPressAction = onPressAction
        self._selectedOption = selectedOption
    }
}
