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
            WorkoutListScreen()
                .tabItem {
                    Label(title: {
                        Text("Workout")
                    }, icon: {
                        Image(systemName: "figure.walk")
                    })
                }
            WorkoutHistoryScreen(workout: Workout())
                .tabItem {
                    Label(title: {
                        Text("History")
                    }, icon: {
                        Image(systemName: "clock")
                    })
                }
        }
        
    }
}

#Preview {
    ContentView()
}
