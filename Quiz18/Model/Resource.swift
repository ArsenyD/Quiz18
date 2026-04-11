import Foundation

struct Resource {
    static let questions = Resource(name: "Questions", fileExtension: "json")
    static let gameHistory = Resource(name: "GameHistory", fileExtension: "json")
    
    var name: String
    var fileExtension: String
    
    init(name: String, fileExtension: String = "json") {
        self.name = name
        self.fileExtension = fileExtension
    }
}
