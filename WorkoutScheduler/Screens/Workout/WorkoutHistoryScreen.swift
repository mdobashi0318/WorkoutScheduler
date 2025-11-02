//
//  HistoryScreen.swift
//  WorkoutTimer
//
//  Created by 土橋正晴 on 2025/08/24.
//

import SwiftUI
import SwiftData

struct WorkoutHistoryScreen: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @Environment(\.modelContext) private var modelContext
    
    @Query private var history: [History]
    
    let workout: Workout
    
    init(workout: Workout) {
        self.workout = workout
        let workoutId: String = workout.id
        _history = Query(
            filter: #Predicate { model in
                model.workout?.id == workoutId
            },
            sort: [SortDescriptor(\History.created_at, order: .reverse)]
        )
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(history) { model in
                    HistoryRow(history: model, isShowTitle: false)
                }
                .onDelete(perform: delete)
            }
            .navigationTitle(workout.name)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    IconButton(action: {
                        dismiss()
                    }, iconName: .xmark)
                }
            }
        }
    }
    
    private func delete(at offsets: IndexSet) {
        for offset in offsets {
            let history = history[offset]
            modelContext.delete(history)
            try? modelContext.save()
        }
    }
    
}

#Preview {
    WorkoutHistoryScreen(workout: Workout())
}
