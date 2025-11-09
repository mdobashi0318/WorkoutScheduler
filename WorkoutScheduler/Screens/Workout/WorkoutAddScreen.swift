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
    
    @State private var workout: Workout
    
    @State private var showAlert = false
    
    @State private var alertMessage = ""
    
    @State private var setCount: Int = 0
        
    init(workout: Workout) {
        _workout = .init(initialValue: workout)
        self.workout.noSaveWorkoutMin = self.workout.workoutMin
        self.workout.noSaveWorkoutSec = self.workout.workoutSec
        self.workout.noSaveIntervalMin = self.workout.intervalMin
        self.workout.noSaveIntervalSec = self.workout.intervalSec
        _setCount = .init(initialValue: workout.setCount)
    }
    
    
    var body: some View {
        NavigationStack {
            Form {
                HStack {
                    Text("\(LocalizeString.Label.localized("Title")): ")
                    underbarTextField(text: $workout.name)
                }
                minSecPickerSection
                intervalPickerSection
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
    
    
    private func underbarTextField(text: Binding<String>, keybordtype: UIKeyboardType = .default) -> some View {
        VStack {
            TextField("", text: text)
                .keyboardType(keybordtype)
            Divider()
        }
    }
    
    private var minSecPickerSection: some View {
        Section(content: {
            TimePicker(min: $workout.noSaveWorkoutMin, sec: $workout.noSaveWorkoutSec)
            Picker(LocalizeString.Label.localized("SetCount"), selection: $setCount) {
                ForEach(0..<11) {
                    Text("\($0)")
                        .tag($0)
                }
            }
            
        }, header: {
            Text(LocalizeString.Label.localized("SetWorkoutTime"))
        })
    }
    
    private var intervalPickerSection: some View {
        Section(content: {
            TimePicker(min: $workout.noSaveIntervalMin, sec: $workout.noSaveIntervalSec)
        }, header: {
            Text(LocalizeString.Label.localized("Interval"))
        })
        
    }
    
    private var topBarLeading: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            IconButton(action: {
                modelContext.rollback()
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
            if workout.id.isEmpty {
                workout.add(setCount: setCount)
                modelContext.insert(workout)
            } else {
                workout.update(setCount: setCount)
            }
            try modelContext.save()
            dismiss()
        } catch {
            alertMessage = LocalizeString.Message.localized("AddError")
            showAlert = true
        }
        
    }
    
    private func validation() -> Bool {
        !workout.name.isEmpty
    }
    
}


#Preview {
    WorkoutAddScreen(workout: Workout())
}
