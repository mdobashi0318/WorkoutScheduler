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
    
    var workoutId: String = ""
    
    /// 実施した時間の累計
    var workoutData: Int = 0
    /// 実施日
    var date: String = ""

    var created_at: String = ""
    
    var updated_at: String = ""
    
    init() {
        id = UUID().uuidString
    }
    
    
    func add(workoutId: String) {
        let now = DateFormatter.created_at
        self.workoutId = workoutId
        date = DateFormatter.format_yyyyMMddHHmm()
        created_at = now
        updated_at = now
    }
    
    func update(workoutId: String) {
        self.workoutId = workoutId
        updated_at = DateFormatter.created_at
    }
    
}
