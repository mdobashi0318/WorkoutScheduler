//
//  TimerView.swift
//  WorkoutScheduler
//
//  Created by 土橋正晴 on 2025/05/02.
//

import SwiftUI

struct TimerView: View {
    
    enum WorkoutStatus: String {
        case notStarted
        case workout
        case interval
        case ended
        
        var title: String {
            LocalizeString.Label.localized(self.localizeKey)
        }
        
        private var localizeKey: String.LocalizationValue {
            return switch self {
            case .workout:
                "DuringExercise"
            case .interval:
                "DuringBreak"
            case .ended:
                "GoodWork"
            default:
                ""
            }
        }
    }
    
    @Environment(\.modelContext) private var modelContext
    
    @State private var timer = TimerObject()
    
    var workout: Workout
    
    @State var isWorkoutSetTime: Bool = false
    @State var isIntervalSetTime: Bool = false
    @State var isCountSet: Bool = false
    
    @State private var workoutStatus: WorkoutStatus = .notStarted
    
    @State private var workoutCount: Int = 0
    
    @State private var isEdit: Bool = true
    
    @State private var isNameSet: Bool = false
    
    let history: History
    
    @State private var isUpdate = false
    
    private let sec: [Int] = {
        var secs: [Int] = []
        for i in 0..<60 where i % 5 == 0 {
            secs.append(i)
        }
        return secs
    }()
    
    var body: some View {
        VStack {
            ZStack {
                Circle()
                    .stroke(lineWidth: 10.0)
                    .opacity(0.2)
                    .foregroundColor(.blue)
                    .frame(width: 200, height: 200)
                
                Circle()
                    .trim(from: 0.0, to: timer.progresValue)
                    .stroke(style: StrokeStyle(lineWidth: 10.0, lineCap: .round, lineJoin: .round))
                    .foregroundColor(.blue)
                    .frame(width: 200, height: 200)
                    .rotationEffect(Angle(degrees: -90))
                    .animation(.linear(duration: 1.0), value: timer.progresValue)
                
                VStack {
                    dispTime
                    if workout.setCount > 0 {
                        Text("\(workoutCount)/\(workout.setCount)")
                    }
                }
            }
            .padding()
            Text(workoutStatus.title)
            
            Spacer()
            buttonSection
                .padding(.bottom, 50)
        }
        .task(id: timer.status) {
            switch timer.status {
            case .Start, .Resume:
                isEdit = true
            case .Pause:
                isEdit = false
            case .End:
                if workoutStatus == .workout {
                    addHistory()
                } else {
                    workoutStatus = .workout
                }
            }
        }
        .onAppear {
            timer.initDisplayTime(workout.workoutMin, workout.workoutSec)
        }
        .onDisappear {
            if workoutStatus == .workout {
                addHistory()
            }
            timer.invalidate()
        }
    }
    
    
    
    private var dispTime: some View {
        let min = "\(timer.displayMin)\(LocalizeString.Label.localized("Min"))"
        let sec = "\(timer.displaySec)\(LocalizeString.Label.localized("Sec"))"
        
        return Text("\(min) \(sec)")
            .dynamicTypeSize(.large)
            .font(.headline)
    }
    
    @ViewBuilder
    private var buttonSection: some View {
        HStack(alignment: .center) {
            if workoutStatus != .notStarted {
                /// キャンセルボタン
                Button(LocalizeString.Button.localized("Cancel"), action: cancel)
                    .buttonStyle(.borderedProminent)
                    .disabled(timer.status == .End)
                    .padding(.leading)
                Spacer()
                
                /// 休憩ボタン
                Button(workoutStatus == .interval ? LocalizeString.Button.localized("Skip") : LocalizeString.Button.localized("Interval")) {
                    timer.invalidate()
                    timer.status = .Start
                    if workoutStatus == .interval {
                        startWorkout()
                    } else {
                        workoutStatus = .interval
                        start(min: workout.intervalMin, sec: workout.intervalSec)
                    }
                }
                .buttonStyle(.borderedProminent)
                .disabled(workout.intervalMin == 0 && workout.intervalSec == 0)
                .padding(.trailing)
            }
            
            /// 開始ボタン
            Button(timer.status.title, action: {
                if workoutStatus == .notStarted {
                    workoutStatus = .workout
                }
                
                if workoutStatus == .workout {
                    startWorkout()
                } else {
                    start(min: workout.intervalMin, sec: workout.intervalSec)
                }
            })
            .buttonStyle(.borderedProminent)
            .disabled(workout.workoutMin == 0 && workout.workoutSec == 0)
            .padding(.trailing)
        }
    }
    
    private func cancel() {
        if workoutStatus == .workout {
            addHistory()
        }
        
        timer.invalidate()
        timer.displayMin = workout.workoutMin
        timer.displaySec = workout.workoutSec
        timer.progresValue = 0
        timer.status = .End
        workoutCount = 0
        workoutStatus = .ended
    }
    
    private func start(min: Int, sec: Int) {
        switch timer.status {
        case .Start, .End:
            timer.startTimer(setMin: min, setSec: sec)
            timer.status = .Pause
        case .Resume:
            timer.startTimer(setMin: min, setSec: sec)
            timer.status = .Pause
        case .Pause:
            timer.invalidate()
            timer.status = .Resume
        }
    }
    
    private func startWorkout() {
        if timer.status != .Pause {
            if workout.setCount > workoutCount {
                workoutCount += 1
            }
        }
        workoutStatus = .workout
        start(min: workout.workoutMin, sec: workout.workoutSec)
    }
    
    private func addHistory() {
        history.workoutData += timer.sec
        if !isUpdate {
            history.add(workoutId: workout.id)
            modelContext.insert(history)
            isUpdate = true
        } else {
            history.update(workoutId: workout.id)
        }
        try? modelContext.save()
    }
    
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(workout: Workout(), history: History())
    }
}
