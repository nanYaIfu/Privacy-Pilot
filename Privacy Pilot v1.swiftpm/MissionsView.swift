import SwiftUI

struct MissionsView: View {
        @EnvironmentObject private var appState: AppState
        private let missions = ContentData.missions
    
        var body: some View {
                List {
                        ForEach(missions) { mission in
                                NavigationLink {
                                        MissionPlayerView(mission: mission)
                                    } label: {
                                            HStack {
                                                    VStack(alignment: .leading, spacing: 4) {
                                                            Text(mission.title).font(.headline)
                                                            Text("\(mission.minutes) min").font(.caption).foregroundStyle(.secondary)
                                                        }
                                                    Spacer()
                                                    if appState.completedMissions.contains(mission.id) {
                                                            Image(systemName: "checkmark.seal.fill")
                                                        }
                                                }
                                        }
                            }
                    }
                .navigationTitle("Missions")
            }
}

struct MissionPlayerView: View {
        @EnvironmentObject private var appState: AppState
        let mission: Mission
    
        @State private var selected: MissionChoice? = nil
        @State private var completed = false
    
        var body: some View {
                ScrollView {
                        VStack(alignment: .leading, spacing: 16) {
                                Text(mission.title).font(.title2).bold()
                                Text(mission.scenario).foregroundStyle(.secondary)
                
                                Text("What do you do?").font(.headline)
                
                                ForEach(mission.choices, id: \.self) { choice in
                                        Button {
                                                selected = choice
                                            } label: {
                                                    HStack {
                                                            Text(choice.text)
                                                            Spacer()
                                                            if selected == choice { Image(systemName: "checkmark.circle.fill") }
                                                        }
                                                    .padding()
                                                    .background(.thinMaterial)
                                                    .clipShape(RoundedRectangle(cornerRadius: 14))
                                                }
                                        .buttonStyle(.plain)
                                    }
                
                                if let selected {
                                        VStack(alignment: .leading, spacing: 8) {
                                                Text(selected.isBest ? "Nice choice" : "Consider this")
                                                    .font(.headline)
                                                Text(selected.feedback)
                                                    .foregroundStyle(.secondary)
                                                Divider()
                                                Text("Takeaway").font(.headline)
                                                Text(mission.takeaway)
                                                    .foregroundStyle(.secondary)
                                            }
                                        .padding()
                                        .background(.ultraThinMaterial)
                                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    
                                        Button(completed ? "Completed" : "Complete Mission") {
                                                guard !completed else { return }
                                                appState.completeMission(mission)
                                                completed = true
                                            }
                                        .padding(.top, 4)
                                    }
                
                                Spacer(minLength: 24)
                            }
                        .padding()
                    }
                .navigationTitle("Mission")
                .navigationBarTitleDisplayMode(.inline)
            }
}

