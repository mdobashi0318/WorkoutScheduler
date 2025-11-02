//
//  HistorySettingScreen.swift
//  WorkoutTimer
//
//  Created by 土橋正晴 on 2025/10/26.
//

import SwiftUI

struct HistorySettingScreen: View {
    
    @Environment(\.dismiss) private var dismiss
    
    @AppStorage("historyMiniMin") var historyMiniMin: Int = 0
    
    var body: some View {
        NavigationStack {
            List {
                Picker("Minimum display interval for history", selection: $historyMiniMin) {
                    ForEach(0..<11) {
                        Text("\($0)")
                            .tag($0)
                    }
                }
            }
            .navigationTitle("History Settings")
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
    HistorySettingScreen()
}
