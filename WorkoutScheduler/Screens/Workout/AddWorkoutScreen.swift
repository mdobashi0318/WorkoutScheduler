//
//  AddWorkoutScreen.swift
//  WorkoutScheduler
//
//  Created by 土橋正晴 on 2025/04/29.
//

import SwiftUI

struct AddWorkoutScreen: View {
    
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        NavigationStack {
            Text("Add Workout Screen")
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
