import Foundation

struct Game: Identifiable, Hashable, Codable {
    let id = UUID()
    let date: Date
    let rightAnswersAmount: Int
    
    enum CodingKeys: CodingKey {
        case date
        case rightAnswersAmount
    }
    
    init(date: Date = .now, rightAnswersAmount: Int) {
        self.date = date
        self.rightAnswersAmount = rightAnswersAmount
    }
}
