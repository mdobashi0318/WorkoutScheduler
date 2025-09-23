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
    
    @State private var showHistorySheet = false
    
    private let history = History()
    
    @State private var timer = TimerObject()
    
    var body: some View {
        Text(workout.name)
        TimerView(timer: $timer, workout: workout, history: history)
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    IconButton(action: {
                        showHistorySheet.toggle()
                    }, iconName: .clock)
                    
                    IconButton(action: {
                        showEditSheet.toggle()
                    }, iconName: .pencil)
                    .disabled(timer.timer?.isValid == true)
                }
            }
            .toolbar(.hidden, for: .tabBar)
            .sheet(isPresented: $showEditSheet) {
                WorkoutAddScreen(workout: workout)
            }
            .sheet(isPresented: $showHistorySheet) {
                WorkoutHistoryScreen(workout: workout)
            }
    }
    
}
