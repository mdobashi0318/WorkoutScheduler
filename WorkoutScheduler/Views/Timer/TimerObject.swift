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
        case Start
        case Pause
        case Resume
        case End
        
        var title: String {
            LocalizeString.Button.localized(self.localizeKey)
        }
        
        private var localizeKey: String.LocalizationValue {
            switch self {
            case .Start:
                "StartWorkout"
            case .Pause:
                "Pause"
            case .Resume:
                "Resume"
            case .End:
                "StartWorkout"
            }
        }
        
    }
    
    var progresValue: CGFloat = 0.0
    var displayMin: Int = 0
    var displaySec: Int = 0
    var status = Status.Start
    
    private(set) var timer :Timer?
    private(set) var sec = 0
    
    func initDisplayTime(_ min: Int, _ sec: Int) {
        self.displayMin = min
        self.displaySec = sec
    }
    
    func startTimer(setMin: Int, setSec: Int) {
        if setMin == 0 && setSec == 0 {
            return
        }
        self.invalidate()
        if status == .Start || status == .End {
            displayMin = setMin
            displaySec = setSec
            progresValue = 0
            sec = 0
        }
        status = .Start
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
                self.status = .End
                AudioServicesPlayAlertSound(SystemSoundID(1013))
            }
        }
    }
    
    func invalidate() {
        timer?.invalidate()
        UIApplication.shared.isIdleTimerDisabled = false
    }
    
    func resetSec() {
        sec = 0
    }
}
