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
    
    let workout: Workout
    
    init(workout: Workout) {
        self.workout = workout
        let workoutId: String = workout.id
        _history = Query(filter: #Predicate { model in
            model.workoutId.localizedStandardContains(workoutId)
        })
    }
    
    var body: some View {
        NavigationStack {
            List {
                ForEach(history) { model in
                    VStack(alignment: .leading) {
                        Text(timeElapsed(dateStr: model.date, addTime: model.workoutData))
                        Text(workoutTime(model.workoutData))
                    }
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
    
    private func workoutTime(_ time: Int) -> String {
        let min = Int(time / 60)
        let sec = time - Int(min * 60)
        return "\(min) \(LocalizeString.Label.localized("Min")) \(sec) \(LocalizeString.Label.localized("Sec"))"
    }
    
    private func timeElapsed(dateStr: String, addTime: Int) -> String {
        let date = DateFormatter.format_yyyyMMddHHmm_str(dateStr)
        guard let modifiedDate = Calendar.current.date(byAdding: .minute, value: Int(addTime / 60), to: date) else {
            return dateStr
        }
        return dateStr + " ~ " + DateFormatter.format_MMddHHmm(modifiedDate)
    }
    
}

#Preview {
    HistoryScreen(workout: Workout())
}
