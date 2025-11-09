//
//  WorkoutAddDataScreen.swift
//  WorkoutTimer
//
//  Created by 土橋正晴 on 2025/11/01.
//

import Foundation
import SwiftUI
import SwiftData

struct WorkoutAddDataScreen: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @Environment(\.modelContext) private var modelContext
    
    var workout: Workout
    
    @State private var workoutMin = 0
    @State private var workoutSec = 0
    
    var body: some View {
        NavigationStack {
            Form {
                minSecPickerSection
            }
            .navigationTitle("Manual Addition")
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    IconButton(action: {
                        dismiss()
                    }, iconName: .xmark)
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    IconButton(action: {
                        addHistory()
                    }, iconName: .plus)
                    .disabled(workoutMin == 0 && workoutSec == 0)
                }
            }
        }
        
    }
    
    private func addHistory() {
        let history = History()
        history.add(workout: workout, addFlag: true)
        history.workoutData = (60 * workoutMin) + workoutSec
        modelContext.insert(history)
        try? modelContext.save()
        dismiss()
    }
    
    
    private var minSecPickerSection: some View {
        Section(content: {
            TimePicker(min: $workoutMin, sec: $workoutSec)
        }, header: {
            Text("Additional time")
        })
    }
    
}
