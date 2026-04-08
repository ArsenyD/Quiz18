import SwiftUI
import Combine

struct QuestionView: View {
    @EnvironmentObject var router: Router
    @State var question: Question
    @State var timeRemaining: Int = 18
    @State private var isTimerExpired = false

    let timer = Timer.publish(every: 1, on: .main, in: .common).autoconnect()
    
    private enum Constants {
        static let buttonSpacing: CGFloat = 10
        static let verticalSpacing: CGFloat = 50
    }
    
    var body: some View {
        VStack(spacing: Constants.verticalSpacing) {
            Text(question.description)
                .bold()
                .font(.title)
            
            QuestionTimerView(timeRemaining: timeRemaining)
            
            VStack(spacing: Constants.buttonSpacing) {
                HStack(spacing: Constants.buttonSpacing) {
                    QuestionButton(for: $question, option: question.options[0])
                    QuestionButton(for: $question, option: question.options[1])
                }
                
                HStack(spacing: Constants.buttonSpacing) {
                    QuestionButton(for: $question, option: question.options[2])
                    QuestionButton(for: $question, option: question.options[3])
                }
                
            }
            .disabled(timeRemaining == 0)
            .padding([.bottom], Constants.buttonSpacing)
        }
        .onReceive(timer) { elapsed in
            guard timeRemaining > 0  else {
                timer.upstream.connect().cancel()
                isTimerExpired = true
                return
            }
            
            guard question.chosenOption == nil else {
                timer.upstream.connect().cancel()
                return
            }
            
            timeRemaining -= 1
        }
        .onChange(of: isTimerExpired) { isTimerExpired in
            if isTimerExpired {
                router.endGame()
            }
        }
    }
}
