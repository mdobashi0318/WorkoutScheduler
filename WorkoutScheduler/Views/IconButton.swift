//
//  IconButton.swift
//  WorkoutScheduler
//
//  Created by 土橋正晴 on 2025/04/28.
//

import SwiftUI


struct IconButton: View {
    
    var action: () -> Void
    
    var iconName: IconName
    
    var body: some View {
        Button(action: {
            action()
        }) {
            Image(systemName: iconName.name)
        }
    }
    
    enum IconName {
        case plus
        case trash
        case ellipsis
        case other(name: String)
        
        
        var name: String {
            switch self {
            case .plus:
                return "plus"
            case .trash:
                return "trash"
            case .ellipsis:
                return "ellipsis"
            case .other(let name):
                return name
            }
        }
    }
    
    
}
