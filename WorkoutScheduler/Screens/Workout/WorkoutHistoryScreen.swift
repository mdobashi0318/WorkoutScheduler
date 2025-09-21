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
                    VStack(alignment: .leading) {
                        Text(timeElapsed(model))
                        Text(workoutTime(model.workoutData))
                    }
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
    
    private func workoutTime(_ time: Int) -> String {
        let min = Int(time / 60)
        let sec = time - Int(min * 60)
        return "\(min) \(LocalizeString.Label.localized("Min")) \(sec) \(LocalizeString.Label.localized("Sec"))"
    }
    
    private func timeElapsed(_ history: History) -> String {
        let endDate = DateFormatter.format_yyyyMMddHHmm_str(history.endDate)
        return history.startDate + "~" + DateFormatter.format_MMddHHmm(endDate)
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
