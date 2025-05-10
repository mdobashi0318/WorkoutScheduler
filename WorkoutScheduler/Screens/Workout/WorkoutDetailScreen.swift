//
//  WorkoutDetailScreen.swift
//  WorkoutScheduler
//
//  Created by 土橋正晴 on 2025/05/02.
//

import SwiftUI

struct WorkoutDetailScreen: View {
    
    var workout: Workout
    
    var body: some View {
        Text(workout.name)
        TimerView(workout: workout)
            .toolbar(.hidden, for: .tabBar)
    }
}
