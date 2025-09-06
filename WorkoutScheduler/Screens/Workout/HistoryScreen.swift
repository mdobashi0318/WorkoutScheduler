//
//  HistoryScreen.swift
//  WorkoutTimer
//
//  Created by 土橋正晴 on 2025/08/24.
//

import SwiftUI
import SwiftData

struct HistoryScreen: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @Query private var history: [History]

    
    var body: some View {
        NavigationStack {
            List {
                ForEach(history) {
                    Text($0.workoutDate)
                    
                }
            }
                .navigationTitle("HistoryScreen")
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        IconButton(action: {
                            dismiss()
                        }, iconName: .xmark)
                    }
                }
        }
    }
}

#Preview {
    HistoryScreen()
}
