import Foundation

@MainActor
final class AppState: ObservableObject {
        private let kPrivacyScore = "privacyScore"
        private let kScoreHistory = "scoreHistory"
        private let kCompletedMissions = "completedMissions"
        private let kBadges = "badges"
    
        @Published var privacyScore: Int
        @Published var scoreHistory: [ScoreEntry]
        @Published var completedMissions: Set<Int>
        @Published var badges: [Badge]
    
        init() {
                self.privacyScore = DefaultsStore.getInt(forKey: kPrivacyScore, default: 0)
                self.scoreHistory = DefaultsStore.getCodable([ScoreEntry].self, forKey: kScoreHistory) ?? []
                self.completedMissions = Set(DefaultsStore.getCodable([Int].self, forKey: kCompletedMissions) ?? [])
                self.badges = DefaultsStore.getCodable([Badge].self, forKey: kBadges) ?? []
            }
    
        func saveScore(_ score: Int) {
                privacyScore = score
                scoreHistory.insert(ScoreEntry(score: score), at: 0)
                if scoreHistory.count > 20 { scoreHistory = Array(scoreHistory.prefix(20)) }
        
                DefaultsStore.setInt(score, forKey: kPrivacyScore)
                DefaultsStore.setCodable(scoreHistory, forKey: kScoreHistory)
            }
    
        func completeMission(_ mission: Mission) {
                completedMissions.insert(mission.id)
                DefaultsStore.setCodable(Array(completedMissions), forKey: kCompletedMissions)
        
                // Badge (only if first time)
                let badgeTitle = "Completed: \(mission.title)"
                if !badges.contains(where: { $0.title == badgeTitle }) {
                        badges.insert(Badge(title: badgeTitle), at: 0)
                        DefaultsStore.setCodable(badges, forKey: kBadges)
                    }
            }
    
        func resetDemoData() {
                privacyScore = 0
                scoreHistory = []
                completedMissions = []
                badges = []
                DefaultsStore.removeAll(keys: [kPrivacyScore, kScoreHistory, kCompletedMissions, kBadges])
            }
}

