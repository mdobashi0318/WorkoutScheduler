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
        NavigationStack {
            VStack {
                Image(systemName: "globe")
                    .imageScale(.large)
                    .foregroundStyle(.tint)
                Text("Hello, world!")
            }
            .padding()
            .navigationTitle("")
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    IconButton(action: {
                        
                    }, iconName: .plus)
                }
            }
        }
        
    }
}

#Preview {
    ContentView()
}
