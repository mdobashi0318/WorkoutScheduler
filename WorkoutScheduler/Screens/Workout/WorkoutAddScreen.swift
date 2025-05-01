//
//  WorkoutAddScreen.swift
//  WorkoutScheduler
//
//  Created by 土橋正晴 on 2025/04/29.
//

import SwiftUI
import SwiftData

struct WorkoutAddScreen: View {
    
    @Environment(\.modelContext) private var modelContext
    
    @Environment(\.dismiss) private var dismiss
    
    @State var workout: Workout
    
    @State private var showAlert = false
    
    @State private var alertMessage = ""
    
    var body: some View {
        NavigationStack {
            Form {
                HStack {
                    Text("\(LocalizeString.Label.localized("Title")):")
                    TextField(LocalizeString.Message.localized("InputTitle"), text: $workout.name)
                }
                
                HStack {
                    Text("\(LocalizeString.Label.localized("SetSec")):")
                    TextField(LocalizeString.Message.localized("InputOneSetSec"), text: $workout.activitieTime)
                        .keyboardType(.numberPad)
                }
                
                HStack {
                    Text("\(LocalizeString.Label.localized("SetCount")):")
                    TextField(LocalizeString.Message.localized("InputSetCount"), text: $workout.setCount)
                        .keyboardType(.numberPad)
                }
            }
            .navigationTitle("AddWorkoutScreen")
            .toolbar {
                topBarLeading
                topBarTrailing
            }
            .alert(alertMessage, isPresented: $showAlert, actions: {
                Button(role: .cancel, action: {
                    showAlert = false
                }, label: {
                    Text(LocalizeString.Button.localized("Close"))
                })
            })
        }
    }
    
    
    private var topBarLeading: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            IconButton(action: {
                dismiss()
            }, iconName: .xmark)
        }
    }
    
    private var topBarTrailing: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            IconButton(action: {
                addWorkout()
            }, iconName: .plus)
        }
    }
    
    private func addWorkout() {
        guard validation() else {
            alertMessage = LocalizeString.Message.localized("Validation")
            showAlert = true
            return
        }
        
        do {
            workout.add()
            modelContext.insert(workout)
            try modelContext.save()
            dismiss()
        } catch {
            alertMessage = LocalizeString.Message.localized("AddError")
            showAlert = true
        }
        
    }
    
    private func validation() -> Bool {
        return if workout.name.isEmpty {
            false
        } else if workout.activitieTime.isEmpty {
            false
        } else if workout.setCount.isEmpty {
            false
        } else {
            true
        }
    }
    
}


#Preview {
    WorkoutAddScreen(workout: Workout())
}
