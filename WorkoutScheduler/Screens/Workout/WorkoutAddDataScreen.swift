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
        
    private let secList: [Int] = {
        var secs: [Int] = []
        for i in 0..<60 where i % 5 == 0 {
            secs.append(i)
        }
        return secs
    }()
    
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
            timePicker(min: $workoutMin, sec: $workoutSec)
        }, header: {
            Text("Additional time")
        })
    }
    
    
    private func timePicker(min: Binding<Int>, sec: Binding<Int>) -> some View {
        HStack {
            HStack {
                Picker("", selection: min) {
                    ForEach(0..<60) {
                        Text("\($0)")
                            .tag($0)
                    }
                }
                Text(LocalizeString.Label.localized("Min"))
            }
            
            HStack {
                Picker("",selection: sec) {
                    ForEach(secList, id: \.self) {
                        Text("\($0)")
                            .tag($0)
                    }
                }
                Text(LocalizeString.Label.localized("Sec"))
            }
        }
        .pickerStyle(.wheel)
        .frame(height: 90)
    }
    
}
