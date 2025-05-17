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
    
    var workout: Workout
    
    @State private var showEditSheet = false
    
    var body: some View {
        Text(workout.name)
        TimerView(workout: workout)
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    IconButton(action: {
                        showEditSheet.toggle()
                    }, iconName: .pencil)
                }
            }
            .toolbar(.hidden, for: .tabBar)
            .sheet(isPresented: $showEditSheet) {
                WorkoutAddScreen(workout: workout)
            }
    }
    

}
