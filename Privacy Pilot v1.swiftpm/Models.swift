import Foundation

struct ScoreEntry: Codable, Identifiable {
        let id: UUID
        let date: Date
        let score: Int
    
        init(date: Date = Date(), score: Int) {
                self.id = UUID()
                self.date = date
                self.score = score
            }
}

struct Badge: Codable, Identifiable, Hashable {
        let id: UUID
        let title: String
        let dateEarned: Date
    
        init(title: String, dateEarned: Date = Date()) {
                self.id = UUID()
                self.title = title
                self.dateEarned = dateEarned
            }
}

struct AnswerOption: Codable, Hashable {
        let title: String
        let score: Int   // 0, 5, 10
        let tip: String
}

struct CheckupQuestion: Codable, Identifiable, Hashable {
        let id: Int
        let prompt: String
        let options: [AnswerOption]
}

struct MissionChoice: Codable, Hashable {
        let text: String
        let isBest: Bool
        let feedback: String
}

struct Mission: Codable, Identifiable, Hashable {
        let id: Int
        let title: String
        let minutes: Int
        let scenario: String
        let choices: [MissionChoice]
        let takeaway: String
}

