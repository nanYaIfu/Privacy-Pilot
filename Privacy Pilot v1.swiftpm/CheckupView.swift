import SwiftUI

struct CheckupView: View {
        @EnvironmentObject private var appState: AppState
        private let questions = ContentData.checkupQuestions
    
        @State private var index = 0
        @State private var selections: [Int: AnswerOption] = [:]
        @State private var showResult = false
        @State private var finalScore: Int = 0
        @State private var topFixes: [String] = []
    
        var body: some View {
                VStack(spacing: 16) {
                        ProgressView(value: Double(index), total: Double(questions.count))
                            .padding(.horizontal)
            
                        let q = questions[index]
                        VStack(alignment: .leading, spacing: 12) {
                                Text("Privacy Checkup").font(.title2).bold()
                                Text(q.prompt).font(.headline)
                
                                ForEach(q.options, id: \.self) { opt in
                                        Button {
                                                selections[q.id] = opt
                                            } label: {
                                                    HStack {
                                                            VStack(alignment: .leading, spacing: 4) {
                                                                    Text(opt.title).font(.body)
                                                                    Text(opt.tip).font(.caption).foregroundStyle(.secondary)
                                                                        .lineLimit(2)
                                                                }
                                                            Spacer()
                                                            if selections[q.id] == opt {
                                                                    Image(systemName: "checkmark.circle.fill")
                                                                } else {
                                                                        Image(systemName: "circle")
                                                                    }
                                                        }
                                                    .padding()
                                                    .background(.thinMaterial)
                                                    .clipShape(RoundedRectangle(cornerRadius: 14))
                                                }
                                        .buttonStyle(.plain)
                                    }
                            }
                        .padding(.horizontal)
            
                        Spacer()
            
                        HStack {
                                Button("Back") {
                                        if index > 0 { index -= 1 }
                                    }
                                .disabled(index == 0)
                
                                Spacer()
                
                                Button(index == questions.count - 1 ? "Finish" : "Next") {
                                        if index == questions.count - 1 {
                                                finish()
                                            } else {
                                                    index += 1
                                                }
                                    }
                                .disabled(selections[questions[index].id] == nil)
                            }
                        .padding()
                    }
                .navigationTitle("Checkup")
                .navigationBarTitleDisplayMode(.inline)
                .sheet(isPresented: $showResult) {
                        CheckupResultView(score: finalScore, topFixes: topFixes)
                    }
            }
    
        private func finish() {
                // Compute score
                let total = questions.reduce(0) { partial, q in
                        partial + (selections[q.id]?.score ?? 0)
                    }
                finalScore = total
                appState.saveScore(total)
        
                // Top 3 fixes: lowest scored answers
                let sorted = questions.compactMap { q -> (Int, String)? in
                        guard let opt = selections[q.id] else { return nil }
                        return (opt.score, opt.tip)
                    }
                .sorted { $0.0 < $1.0 }
        
                topFixes = Array(sorted.prefix(3).map { "• " + $0.1 })
        
                showResult = true
            }
}

struct CheckupResultView: View {
        let score: Int
        let topFixes: [String]
    
        var body: some View {
                NavigationStack {
                        VStack(alignment: .leading, spacing: 16) {
                                Text("Your Privacy Score").font(.headline)
                                Text("\(score)")
                                    .font(.system(size: 64, weight: .bold))
                
                                Text("Top fixes").font(.headline)
                                VStack(alignment: .leading, spacing: 8) {
                                        ForEach(topFixes, id: \.self) { Text($0) }
                                    }
                                .foregroundStyle(.secondary)
                
                                Spacer()
                            }
                        .padding()
                        .navigationTitle("Results")
                        .navigationBarTitleDisplayMode(.inline)
                    }
            }
}

