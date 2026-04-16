import SwiftUI

struct GameResultView: View {
    // MARK: Properties
    @EnvironmentObject private var router: Router
    @EnvironmentObject private var gameEngine: GameEngine
    
    let game: Game
    
    // MARK: Body
    var body: some View {
        VStack {
            Spacer()
            
            GameResultIndicator(result: game.rightAnswersAmount)
            
            Spacer()
            
            PrimaryButton("Play Again") {
                let firstQuestion = gameEngine.prepareGame()
                
                router.startGame(with: firstQuestion)
            }
            .padding(.horizontal)
            
            SecondaryButton("Go to menu") {
                router.navigateToMain()
            }
            .padding([.bottom, .horizontal])
            .padding(.top, 15)
        }
        .navigationTitle("Game Over")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    // MARK: Init
    init(for game: Game) {
        self.game = game
    }
}
