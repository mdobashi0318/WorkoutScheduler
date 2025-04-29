//
//  WorkoutScreen.swift
//  WorkoutScheduler
//
//  Created by 土橋正晴 on 2025/04/29.
//

import SwiftUI

struct WorkoutScreen: View {
    
    @State private var showAddWorkout = false
    
    var body: some View {
        NavigationStack {
            Text("WorkoutScreen")
                .toolbar {
                    topBarTrailing
                }
        }
        .fullScreenCover(isPresented: $showAddWorkout) {
            AddWorkoutScreen()
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

