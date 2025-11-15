//
//  TimePicker.swift
//  WorkoutTimer
//
//  Created by 土橋正晴 on 2025/11/03.
//

import Foundation
import SwiftUI

struct TimePicker: View {
    
    @Binding var min: Int
    @Binding var sec: Int
    
    var body: some View {
        HStack {
            HStack {
                Picker("", selection: $min) {
                    ForEach(0..<60) {
                        Text("\($0)")
                            .tag($0)
                    }
                }
                Text(LocalizeString.Label.localized("Min"))
            }
            
            HStack {
                Picker("",selection: $sec) {
                    ForEach(secList, id: \.self) {
                        Text("\($0)")
                            .tag($0)
                    }
                }
                Text(LocalizeString.Label.localized("Sec"))
            }
        }
        .pickerStyle(.wheel)
        .frame(height: 90)
    }
    
    private let secList: [Int] = {
        var secs: [Int] = []
        for i in 0..<60 where i % 5 == 0 {
            secs.append(i)
        }
        return secs
    }()
    
}
