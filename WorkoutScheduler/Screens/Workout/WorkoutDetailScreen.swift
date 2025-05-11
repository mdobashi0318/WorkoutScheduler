//
//  WorkoutDetailScreen.swift
//  WorkoutScheduler
//
//  Created by 土橋正晴 on 2025/05/02.
//

import SwiftUI
import SwiftData

struct WorkoutDetailScreen: View {
    
    @Environment(\.modelContext) private var modelContext
    
    @State var workout: Workout
    
    var body: some View {
        Text(workout.name)
        TimerView(workout: $workout)

            .toolbar(.hidden, for: .tabBar)
            .task(id: workout.workoutMin) {
                try? modelContext.save()
            }
            .task(id: workout.workoutSec) {
                try? modelContext.save()
            }
            .task(id: workout.intervalMin) {
                try? modelContext.save()
            }
            .task(id: workout.intervalSec) {
                try? modelContext.save()
            }
            .task(id: workout.setCount) {
                try? modelContext.save()
            }
            .task(id: workout.name) {
                try? modelContext.save()
            }
    }
    

}
