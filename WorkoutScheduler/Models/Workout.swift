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
    ///  min
    var workoutMin: Int = 0
    ///  sec
    var workoutSec: Int = 0
    /// セット数
    var setCount: Int = 0
    
    var intervalMin: Int = 0
    var intervalSec: Int = 0
    
    var created_at: String = ""
    
    var updated_at: String = ""
    
    @Transient
    var noSaveWorkoutMin: Int = 0
    @Transient
    var noSaveWorkoutSec: Int = 0
    @Transient
    var noSaveIntervalMin: Int = 0
    @Transient
    var noSaveIntervalSec: Int = 0
    @Transient
    var noSaveSetCount: Int = 0
    
    init() { }
    
    func add() {
        let date = DateFormatter.created_at
        id = UUID().uuidString
        setTime()
        created_at = date
        updated_at = date
    }
    
    func update() {
        setTime()
        updated_at = DateFormatter.created_at
    }
    
    
    private func setTime() {
        workoutMin = noSaveWorkoutMin
        workoutSec = noSaveWorkoutSec
        setCount = noSaveSetCount
        intervalMin = noSaveIntervalMin
        intervalSec = noSaveIntervalSec
    }
    
}
