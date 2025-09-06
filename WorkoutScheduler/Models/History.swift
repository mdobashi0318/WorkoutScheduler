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
    
    /// 実施日
    var workoutDate: String = ""

    var created_at: String = ""
    
    var updated_at: String = ""
    
    init() { }
    
    
    func add(id: String, workoutId: String) {
        let now = DateFormatter.created_at
        self.id = id
        self.workoutId = workoutId
        workoutDate = DateFormatter.format_yyyyMMddHHmm()
        created_at = now
        updated_at = now
    }
    
}
