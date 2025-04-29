//
//  ContentView.swift
//  WorkoutScheduler
//
//  Created by 土橋正晴 on 2024/09/24.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    var body: some View {
        TabView {
            Tab("Schedule", systemImage: "calendar") {
                VStack {
                    Text("Tab1")
                }
            }
            
            Tab("Workout", systemImage: "dumbbell") {
                WorkoutScreen()
            }
        }
        
    }
}

#Preview {
    ContentView()
}
