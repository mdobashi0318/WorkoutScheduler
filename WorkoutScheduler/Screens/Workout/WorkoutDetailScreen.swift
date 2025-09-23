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
    
    var body: some View {
        Text(workout.name)
        TimerView(workout: workout, history: history)
            .toolbar {
                ToolbarItemGroup(placement: .topBarTrailing) {
                    IconButton(action: {
                        showHistorySheet.toggle()
                    }, iconName: .clock)
                    IconButton(action: {
                        showEditSheet.toggle()
                    }, iconName: .pencil)
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
