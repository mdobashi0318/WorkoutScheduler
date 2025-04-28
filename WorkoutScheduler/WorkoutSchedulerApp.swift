//
//  WorkoutSchedulerApp.swift
//  WorkoutScheduler
//
//  Created by 土橋正晴 on 2024/09/24.
//

import SwiftUI
import SwiftData

@main
struct WorkoutSchedulerApp: App {
    
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegates
    
    var body: some Scene {
        WindowGroup {
            ContentView()
                .modelContainer(for: [Workout.self, WorkoutSchedule.self])
        }
    }
}
