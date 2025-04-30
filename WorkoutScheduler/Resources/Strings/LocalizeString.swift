//
//  LocalizeString.swift
//  WorkoutScheduler
//
//  Created by 土橋正晴 on 2025/04/30.
//

import Foundation

enum LocalizeString: String {
    
    case Message
    case Label
    
    func localized(_ key: String.LocalizationValue) -> String {
        String(localized: key, table: self.rawValue)
    }
}
