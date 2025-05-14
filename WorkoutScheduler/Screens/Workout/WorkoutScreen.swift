//
//  WorkoutScreen.swift
//  WorkoutScheduler
//
//  Created by 土橋正晴 on 2025/04/29.
//

import SwiftUI
import SwiftData

struct WorkoutScreen: View {
    
    @Environment(\.modelContext) private var modelContext
    
    @State private var showAddWorkout = false
    
    @Query private var workouts: [Workout]
    
    @State private var showAlert: Bool = false
    
    init() {
        _workouts = Query(sort: [SortDescriptor(\Workout.name)])
    }

    var body: some View {
        NavigationStack {
            List {
                ForEach(workouts) { workout in
                    NavigationLink(value: workout) {
                        Text(workout.name)
                    }
                }
                .onDelete(perform: delete)
            }
            .navigationTitle("WorkoutScreen")
            .navigationDestination(for: Workout.self) {
                WorkoutDetailScreen(workout: $0)
            }
            .toolbar {
                topBarTrailing
            }
            .alert(LocalizeString.Message.localized("deleteError"), isPresented: $showAlert, actions: {
                  Button(role: .cancel, action: {
                      showAlert = false
                  }, label: {
                      Text(LocalizeString.Message.localized("Close"))
                  })
              })
        }
        .fullScreenCover(isPresented: $showAddWorkout) {
            WorkoutAddScreen(workout: Workout())
        }
    }
    
    
    
    private var topBarTrailing: some ToolbarContent {
        ToolbarItem(placement: .topBarTrailing) {
            IconButton(action: {
                showAddWorkout = true
            }, iconName: .plus)
        }
    }
    
    
    private func delete(at offsets: IndexSet) {
        for offset in offsets {
            do {
                let workout = workouts[offset]
                modelContext.delete(workout)
                try modelContext.save()
            } catch {
                showAlert = true
            }
        }
    }
    
}

