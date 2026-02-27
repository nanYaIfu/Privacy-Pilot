import SwiftUI

struct HomeView: View {
    @EnvironmentObject private var appState: AppState
    @Binding var path: [Route]
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                VStack(alignment: .leading, spacing: 6) {
                    Text("Privacy Pilot")
                        .font(.largeTitle).bold()
                    Text("Quick, teen-friendly privacy skills.")
                        .font(.subheadline)
                        .foregroundStyle(.secondary)
                }
                
                HStack(spacing: 12) {
                    statCard(title: "Score", value: "\(appState.privacyScore)")
                    statCard(title: "Missions", value: "\(appState.completedMissions.count)/\(ContentData.missions.count)")
                }
                
                actionCard(title: "Start Checkup", subtitle: "10 questions → score + top fixes") {
                    path.append(.checkup)
                }
                actionCard(title: "Try Simulator", subtitle: "See who can view a post") {
                    path.append(.simulator)
                }
                actionCard(title: "Missions", subtitle: "Short scenarios (2–3 min)") {
                    path.append(.missions)
                }
                actionCard(title: "Progress", subtitle: "Badges + score history") {
                    path.append(.progress)
                }
            }
            .padding()
        }
    }
    
    private func statCard(title: String, value: String) -> some View {
        VStack(alignment: .leading, spacing: 6) {
            Text(title).font(.caption).foregroundStyle(.secondary)
            Text(value).font(.title2).bold()
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding()
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
    
    private func actionCard(title: String, subtitle: String, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            VStack(alignment: .leading, spacing: 6) {
                Text(title).font(.headline)
                Text(subtitle).font(.subheadline).foregroundStyle(.secondary)
            }
            .frame(maxWidth: .infinity, alignment: .leading)
            .padding()
            .background(.ultraThinMaterial)
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
        .buttonStyle(.plain)
    }
}

