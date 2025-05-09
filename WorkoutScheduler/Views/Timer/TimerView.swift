//
//  TimerView.swift
//  WorkoutScheduler
//
//  Created by 土橋正晴 on 2025/05/02.
//

import SwiftUI

struct TimerView: View {
    
    enum WorkoutStatus {
        case workout
        case interval
    }
    
    @State private var timer = TimerObject()
    
    @State var workout: Workout
    
    @State var isWorkoutSetTime: Bool = false
    @State var isIntervalSetTime: Bool = false
    @State var isCountSet: Bool = false
    
    @State private var workoutStatus: WorkoutStatus = .workout
    
    @State private var workoutCount: Int = 0
    
    @State private var isEdit: Bool = true
    
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
            buttonSection
            Form() {
                if isEdit {
                    TimeSetSection
                    countSetView
                }
            }
        }
        .task(id: timer.status) {
            switch timer.status {
            case .Start, .Resume:
                isEdit = true
            case .Pause:
                isEdit = false
            }
        }
    }
    
    private var dispTime: some View {
        let min = "\(timer.status == .Start ?  workout.workoutMin : timer.displayMin)\(LocalizeString.Label.localized("Min"))"
        let sec = "\(timer.status == .Start ?  workout.workoutSec : timer.displaySec)\(LocalizeString.Label.localized("Sec"))"
        
        return Text("\(min) \(sec)")
            .dynamicTypeSize(.large)
            .font(.headline)
    }
    
    private var TimeSetSection: some View {
        Section {
            workoutTimeSetView
            intervalTimeSetView
        }
    }
    
    @ViewBuilder
    private var workoutTimeSetView: some View {
        Toggle(isOn: $isWorkoutSetTime, label: {
            Text(LocalizeString.Label.localized("EditTime"))
        })
        if isWorkoutSetTime {
            HStack {
                HStack {
                    Picker(selection: $workout.workoutMin) {
                        ForEach(0..<61) {
                            Text("\($0)")
                        }
                    } label: { }
                        .pickerStyle(.wheel)
                    Text(LocalizeString.Label.localized("Min"))
                }
                HStack {
                    Picker(selection: $workout.workoutSec) {
                        ForEach(sec, id: \.self) {
                            Text("\($0)")
                        }
                    } label: { }
                        .pickerStyle(.wheel)
                    Text(LocalizeString.Label.localized("Sec"))
                }
            }
            .frame(height: 90)
        }
    }
    
    @ViewBuilder
    private var intervalTimeSetView: some View {
        Toggle(isOn: $isIntervalSetTime, label: {
            Text(LocalizeString.Label.localized("EditInterval"))
        })
        if isIntervalSetTime {
            HStack {
                HStack {
                    Picker(selection: $workout.intervalMin) {
                        ForEach(0..<61) {
                            Text("\($0)")
                        }
                    } label: { }
                        .pickerStyle(.wheel)
                    Text(LocalizeString.Label.localized("Min"))
                }
                HStack {
                    Picker(selection: $workout.intervalSec) {
                        ForEach(sec, id: \.self) {
                            Text("\($0)")
                        }
                    } label: { }
                        .pickerStyle(.wheel)
                    Text(LocalizeString.Label.localized("Sec"))
                }
            }
            .frame(height: 90)
        }
    }
    
    
    @ViewBuilder
    private var countSetView: some View {
        Toggle(isOn: $isCountSet, label: {
            Text(LocalizeString.Label.localized("EditSetCount"))
        })
        
        if isCountSet {
            Picker(LocalizeString.Label.localized("SetCount"), selection: $workout.setCount) {
                ForEach(1..<61) {
                    Text("\($0)")
                        .tag($0)
                }
            }
        }
    }
    
    @ViewBuilder
    private var buttonSection: some View {
        HStack(alignment: .center) {
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
            .padding(.trailing, 2.5)
            
            Button(LocalizeString.Button.localized(String.LocalizationValue(timer.status.rawValue)), action: {
                if workoutStatus == .workout {
                    startWorkout()
                } else {
                    start(min: workout.intervalMin, sec: workout.intervalSec)
                }
            })
            .buttonStyle(.borderedProminent)
            .disabled(workout.workoutMin == 0 && workout.workoutSec == 0)
            .padding(.leading, 2.5)
        }
        
        Button(LocalizeString.Button.localized("Cancel"), action: cancel)
            .buttonStyle(.borderedProminent)
            .disabled(timer.status == .Start)
            .padding(.top)
    }
    
    private func cancel() {
        timer.invalidate()
        timer.displayMin = workout.workoutMin
        timer.displaySec = workout.workoutSec
        timer.progresValue = 0
        timer.status = .Start
        workoutCount = 0
    }
    
    private func start(min: Int, sec: Int) {
        switch timer.status {
        case .Start, .Resume:
            timer.startTimer(setMin: min, setSec: sec)
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
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(workout: Workout())
    }
}
