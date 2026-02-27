import SwiftUI

struct ProgressView: View {
    @EnvironmentObject private var appState: AppState
    
    var body: some View {
        List {
            Section("Privacy Score") {
                HStack {
                    Text("Current")
                    Spacer()
                    Text("\(appState.privacyScore)").bold()
                }
            }
            
            Section("History") {
                if appState.scoreHistory.isEmpty {
                    Text("No checkups yet.")
                        .foregroundStyle(.secondary)
                } else {
                    ForEach(appState.scoreHistory) { entry in
                        HStack {
                            Text(entry.date, style: .date)
                            Spacer()
                            Text("\(entry.score)")
                        }
                    }
                }
            }
            
            Section("Badges") {
                if appState.badges.isEmpty {
                    Text("No badges yet.")
                        .foregroundStyle(.secondary)
                } else {
                    ForEach(appState.badges) { badge in
                        VStack(alignment: .leading, spacing: 4) {
                            Text(badge.title)
                            Text(badge.dateEarned, style: .date)
                                .font(.caption)
                                .foregroundStyle(.secondary)
                        }
                    }
                }
            }
            
            Section {
                Button(role: .destructive) {
                    appState.resetDemoData()
                } label: {
                    Text("Reset demo data")
                }
            }
        }
        .navigationTitle("Progress")
    }
}

