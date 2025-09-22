//
//  HistoryListScreen.swift
//  WorkoutTimer
//
//  Created by 土橋正晴 on 2025/09/21.
//

import SwiftUI
import SwiftData

struct HistoryListScreen: View {
    
    @Query private var historys: [History] = []
    
    @Environment(\.modelContext) private var modelContext
    
    private let dispSec: Int = 30
    
    init() {
        _historys = Query(
            filter: #Predicate { model in
                model.workoutData >= dispSec
            },
            sort: [SortDescriptor(\History.created_at, order: .reverse)]
        )
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                List {
                    ForEach(historys) { history in
                        NavigationLink(value: history.workout, label: {
                            VStack(alignment: .leading) {
                                Text(history.workout?.name ?? "")
                                Text(history.timeElapsed())
                                Text(history.workoutTime())
                            }
                        })
                    }
                    .onDelete(perform: delete)
                }
                .navigationTitle("HistoryListScreen")
                
                if historys.isEmpty {
                    Text("NoHistoryList \(dispSec)")
                        .font(.subheadline)
                }
            }
            .navigationDestination(for: Workout.self, destination: {
                WorkoutDetailScreen(workout: $0)
            })
        }
    }
    
    private func delete(at offsets: IndexSet) {
        for offset in offsets {
            let history = historys[offset]
            modelContext.delete(history)
            try? modelContext.save()
        }
    }
    
}

#Preview {
    HistoryListScreen()
}
