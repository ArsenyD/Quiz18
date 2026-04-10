import Foundation

struct Question: Identifiable, Decodable, Hashable {
    struct QuestionOption: Identifiable, Equatable, Decodable, Hashable {
        let id: Int
        let description: String
        let isCorrect: Bool
    }
    
    enum QuestionDifficulty: String, Decodable {
        case easy
        case medium
        case hard
        case hardcore
    }
    
    enum CodingKeys: CodingKey {
        case id
        case description
        case difficulty
        case options
    }
    
    let id: Int
    let description: String
    let difficulty: QuestionDifficulty
    let options: [QuestionOption]
}
