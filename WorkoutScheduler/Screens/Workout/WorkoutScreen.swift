//
//  WorkoutScreen.swift
//  WorkoutScheduler
//
//  Created by 土橋正晴 on 2025/04/29.
//

import SwiftUI
import SwiftData

struct WorkoutScreen: View {
    
    @State private var showAddWorkout = false
    
    @Query private var workouts: [Workout]
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(workouts) { workout in
                    NavigationLink(value: workout) {
                        Text(workout.name)
                    }
                }
            }
            .navigationTitle("WorkoutScreen")
            .navigationDestination(for: Workout.self) {
                WorkoutDetailScreen(workout: $0)
            }
            .toolbar {
                topBarTrailing
            }
        }
        
        .fullScreenCover(isPresented: $showAddWorkout) {
            WorkoutAddScreen(workout: Workout())
        }
    }
    
    
    
    private var topBarTrailing: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            IconButton(action: {
                showAddWorkout = true
            }, iconName: .plus)
        }
    }
}

