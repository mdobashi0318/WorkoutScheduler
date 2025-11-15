//
//  History.swift
//  WorkoutTimer
//
//  Created by 土橋正晴 on 2025/08/04.
//

import Foundation
import SwiftData

@Model
class History {
    
    @Attribute(.unique)
    var id: String = ""
    /// 実施した時間の累計
    var workoutData: Int = 0
    /// 実施日
    var startDate: String = ""
    
    var endDate: String = ""
    
    var workout: Workout?

    ///  手動で追加した
    var addFlag = false
    
    var created_at: String = ""
    
    var updated_at: String = ""
    
    init() {
        id = UUID().uuidString
    }
    
    func add(workout: Workout, addFlag: Bool = false) {
        let now = DateFormatter.created_at
        startDate = DateFormatter.format_yyyyMMddHHmm()
        endDate = DateFormatter.format_yyyyMMddHHmm()
        self.workout = workout
        created_at = now
        updated_at = now
        self.addFlag = addFlag
    }
    
    func update() {
        endDate = DateFormatter.format_yyyyMMddHHmm()
        updated_at = DateFormatter.created_at
    }
    
    
    func workoutTime() -> String {
        let time = workoutData
        let min = Int(time / 60)
        let sec = time - Int(min * 60)
        return "\(min) \(LocalizeString.Label.localized("Min")) \(sec) \(LocalizeString.Label.localized("Sec"))"
    }
    
    
    func timeElapsed() -> String {
        let endDate = DateFormatter.format_yyyyMMddHHmm_str(self.endDate)
        return self.startDate + "~" + DateFormatter.format_MMddHHmm(endDate)
    }
    
}
