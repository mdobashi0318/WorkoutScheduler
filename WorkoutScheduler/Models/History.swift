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

    var created_at: String = ""
    
    var updated_at: String = ""
    
    init() {
        id = UUID().uuidString
    }
    
    
    func add(workout: Workout) {
        let now = DateFormatter.created_at
        startDate = DateFormatter.format_yyyyMMddHHmm()
        endDate = DateFormatter.format_yyyyMMddHHmm()
        self.workout = workout
        created_at = now
        updated_at = now
    }
    
    func update() {
        endDate = DateFormatter.format_yyyyMMddHHmm()
        updated_at = DateFormatter.created_at
    }
    
}
