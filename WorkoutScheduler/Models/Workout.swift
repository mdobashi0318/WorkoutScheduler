//
//  Workout.swift
//  WorkoutScheduler
//
//  Created by 土橋正晴 on 2025/01/13.
//

import RealmSwift

class Workout: Object, RealmProtocol {
    
    typealias Model = Workout
    
    @Persisted var id: String = ""
    
    
    
    static func allFetch() throws -> [Workout] {
        []
    }
    
    
    static func fetch(id: String) throws -> Workout {
        guard let realm = RealmManager.realm else {
            throw DBError(message: R.string.messages.addFailed(), type: .fetchFailed)
        }
        return Workout()
    }
    
    static func add(_ model: Workout) throws {
        guard let realm = RealmManager.realm else {
            throw DBError(message: R.string.messages.addFailed(), type: .addFailed)
        }
        
    }
    
    static func update(_ model: Workout) throws {
        guard let realm = RealmManager.realm else {
            throw DBError(message: R.string.messages.updateFailed(), type: .updateFailed)
        }
    }
    
    static func delete(_ model: Workout) throws {
        guard let realm = RealmManager.realm else {
            throw DBError(message: R.string.messages.deleteFailed(), type: .deleteFailed)
        }
        
    }
    
    static func allDetele() throws {
        guard let realm = RealmManager.realm else {
            throw DBError(message: R.string.messages.deleteFailed(), type: .deleteFailed)
        }
    }
    
    
    
    
    
    
    
    
    
}
