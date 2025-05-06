//
//  TimerObject.swift
//  WorkoutScheduler
//
//  Created by 土橋正晴 on 2025/05/02.
//

import Foundation
import AudioToolbox
import UIKit
import Observation


@Observable
class TimerObject {

    enum Status: String {
        case Start = "StartWorkout"
        case Pause
        case Resume
    }
    
    var progresValue: CGFloat = 0.0
    var displayMin: Int = 0
    var displaySec: Int = 0
    var status = Status.Start
    
    private var timer :Timer?
    private var sec = 0
    
    func startTimer(setMin: Int, setSec: Int) {
        if setMin == 0 && setSec == 0 {
            return
        }
        self.invalidate()
        if status == .Start {
            displayMin = setMin
            displaySec = setSec
            progresValue = 0
            sec = 0
        }
        status = .Pause
        UIApplication.shared.isIdleTimerDisabled = true
        
        timer = Timer.scheduledTimer(withTimeInterval: 1, repeats: true) { timer in
            if self.displaySec == 0 {
                self.displayMin -= 1
                self.displaySec = 59
            } else {
                self.displaySec -= 1
            }
            self.progresValue += 1 / (CGFloat((60 * setMin) + setSec))
            self.sec += 1
            if self.sec == (60 * setMin) + setSec {
                self.invalidate()
                self.status = .Start
                AudioServicesPlayAlertSound(SystemSoundID(1013))
            }
        }
    }
    
    func invalidate() {
        timer?.invalidate()
        UIApplication.shared.isIdleTimerDisabled = false
    }
}
