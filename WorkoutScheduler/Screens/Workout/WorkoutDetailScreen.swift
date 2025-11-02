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
    
    @State private var showAddData = false
    
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
                        showAddData.toggle()
                    }, iconName: .other(name: "pencil.tip.crop.circle.badge.plus"))
                                        
                    Button(action: {
                        showEditSheet.toggle()
                    }, label: {
                        Text("Edit")
                    })
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
            .sheet(isPresented: $showAddData) {
                WorkoutAddDataScreen(workout: workout)
                    .presentationDetents([.medium])
            }
    }
    
}
