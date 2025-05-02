//
//  Workout.swift
//  WorkoutScheduler
//
//  Created by 土橋正晴 on 2025/01/13.
//

import Foundation
import SwiftData

@Model
class Workout {
    @Attribute(.unique)
    var id: String = ""
    
    var name: String = ""
    /// １セットの秒数
    var activitieTime: String = ""
    /// セット数
    var setCount: String = ""
    
    var interval: String = ""
    
    var created_at: String = ""
    
    var updated_at: String = ""
    
    init() { }
    
    func add() {
        let date = DateFormatter.created_at
        id = UUID().uuidString
        created_at = date
        updated_at = date
    }
    
}
