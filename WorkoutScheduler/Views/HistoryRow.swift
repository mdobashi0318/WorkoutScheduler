//
//  HistoryRow.swift
//  WorkoutTimer
//
//  Created by 土橋正晴 on 2025/11/02.
//

import SwiftUI

struct HistoryRow: View {
    
    let history: History
    
    let isShowTitle: Bool
    
    var body: some View {
        VStack(alignment: .leading) {
            if isShowTitle {
                Text(history.workout?.name ?? "")
            }
            Text(history.addFlag ? "\(history.startDate)(Manual recording)" : history.timeElapsed())
            Text(history.workoutTime())
        }
    }
}
