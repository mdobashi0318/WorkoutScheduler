//
//  HistoryScreen.swift
//  WorkoutTimer
//
//  Created by 土橋正晴 on 2025/08/24.
//

import SwiftUI
import SwiftData

struct HistoryScreen: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @Query private var history: [History]
    
    let workout: Workout
    
    init(workout: Workout) {
        self.workout = workout
        let workoutId: String = workout.id
        _history = Query(filter: #Predicate { model in
            model.workoutId.localizedStandardContains(workoutId)
        })
    }

    
    var body: some View {
        NavigationStack {
            List {
                ForEach(history) { model in
                    VStack(alignment: .leading) {
                        Text(workout.name)
                        Text(model.date)
                        Text("\(model.workoutData)")
                    }
                }
            }
                .navigationTitle("HistoryScreen")
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        IconButton(action: {
                            dismiss()
                        }, iconName: .xmark)
                    }
                }
        }
    }
}

#Preview {
    HistoryScreen(workout: Workout())
}
