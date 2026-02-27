import SwiftUI

enum Audience: String, CaseIterable, Identifiable {
    case `public` = "Public"
    case friends = "Friends"
    case closeFriends = "Close Friends"
    var id: String { rawValue }
}

struct SimulatorView: View {
    @State private var audience: Audience = .public
    @State private var locationOn = true
    @State private var taggingOn = true
    @State private var reshareOn = true
    @State private var msgRequestsOn = true
    
    var body: some View {
        ScrollView {
            VStack(alignment: .leading, spacing: 16) {
                Text("Who can see this?")
                    .font(.title2).bold()
                
                mockPostCard
                
                Group {
                    Picker("Audience", selection: $audience) {
                        ForEach(Audience.allCases) { a in
                            Text(a.rawValue).tag(a)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    Toggle("Location", isOn: $locationOn)
                    Toggle("Tagging", isOn: $taggingOn)
                    Toggle("Allow Reshare", isOn: $reshareOn)
                    Toggle("Message Requests", isOn: $msgRequestsOn)
                }
                .padding()
                .background(.thinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 16))
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("Exposure Meter").font(.headline)
                    ProgressView(value: Double(exposureScore), total: 100)
                    Text(riskSummary)
                        .foregroundStyle(.secondary)
                }
                .padding()
                .background(.ultraThinMaterial)
                .clipShape(RoundedRectangle(cornerRadius: 16))
            }
            .padding()
        }
        .navigationTitle("Simulator")
        .navigationBarTitleDisplayMode(.inline)
    }
    
    private var exposureScore: Int {
        var score = 0
        
        // Audience base
        switch audience {
        case .public: score += 55
        case .friends: score += 25
        case .closeFriends: score += 10
        }
        
        if locationOn { score += 15 }
        if taggingOn { score += 10 }
        if reshareOn { score += 10 }
        if msgRequestsOn { score += 10 }
        
        return min(score, 100)
    }
    
    private var riskSummary: String {
        if exposureScore >= 70 {
            return "High exposure: public reach + extra signals (location/tags) make you more searchable."
        } else if exposureScore >= 40 {
            return "Medium exposure: good start—tighten one or two settings for less unwanted visibility."
        } else {
            return "Low exposure: limited audience and fewer signals reduce searchability and random contact."
        }
    }
    
    private var mockPostCard: some View {
        VStack(alignment: .leading, spacing: 10) {
            RoundedRectangle(cornerRadius: 14)
                .frame(height: 180)
                .overlay(Text("Mock Photo").foregroundStyle(.secondary))
            
            Text("Hanging out after practice 😄")
                .font(.headline)
            
            HStack(spacing: 8) {
                Text("#weekend")
                if taggingOn { Text("#myteam") }
            }
            .foregroundStyle(.secondary)
            
            if locationOn {
                Text("📍 City Park")
                    .foregroundStyle(.secondary)
            }
        }
        .padding()
        .background(.thinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

