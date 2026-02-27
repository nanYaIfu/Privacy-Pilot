import SwiftUI

enum Route: Hashable {
    case checkup
    case simulator
    case missions
    case progress
}

struct RootView: View {
    @State private var path: [Route] = []
    
    var body: some View {
        NavigationStack(path: $path) {
            HomeView(path: $path)
                .navigationDestination(for: Route.self) { route in
                    switch route{
                    case .checkup: CheckupView()
                    case .simulator: SimulatorView()
                    case .missions: MissionsView()
                    case .progress: ProgressView()
                        
                    }
            }
        }
    }
}
