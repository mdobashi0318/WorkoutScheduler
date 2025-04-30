//
//  AddWorkoutScreen.swift
//  WorkoutScheduler
//
//  Created by 土橋正晴 on 2025/04/29.
//

import SwiftUI

struct AddWorkoutScreen: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @State var workout: Workout
    
    var body: some View {
        NavigationStack {
            Form {
                HStack {
                    Text("\(LocalizeString.Label.localized("Title")):")
                    Spacer()
                    TextField(LocalizeString.Message.localized("InputTitle"), text: $workout.name)
                }
                
                HStack {
                    Text("\(LocalizeString.Label.localized("SetSec")):")
                    Spacer()
                    TextField(LocalizeString.Message.localized("InputOneSetSec"), text: $workout.activitieTime)
                }
            }
            .navigationTitle("AddWorkoutScreen")
            .toolbar {
                topBarLeading
            }
        }
    }
    
    
    private var topBarLeading: some ToolbarContent {
        ToolbarItem(placement: .topBarLeading) {
            IconButton(action: {
                dismiss()
            }, iconName: .xmark)
        }
    }
    
}
