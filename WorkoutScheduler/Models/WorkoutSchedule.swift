//
//  WorkoutSchedule.swift
//  WorkoutScheduler
//
//  Created by 土橋正晴 on 2025/01/19.
//

import SwiftData

@Model
class WorkoutSchedule {
    
    @Attribute(.unique)
    var id: String = ""
    
    var name: String = ""
    /// Workoutのキー値
    var workoutId: String = ""
    
    var created_at: String = ""
    
    var updated_at: String = ""
    
    init() { }
    
}
