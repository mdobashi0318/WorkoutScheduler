//
//  Errors.swift
//  WorkoutScheduler
//
//  Created by 土橋正晴 on 2025/01/13.
//

import Foundation

// MARK: - Error

struct DBError: Error {
    var message: String
    var type: ErrorType
    
    enum ErrorType {
        case fetchFailed
        case addFailed
        case updateFailed
        case deleteFailed
    }
}
