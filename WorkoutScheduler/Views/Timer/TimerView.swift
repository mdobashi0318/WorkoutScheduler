//
//  TimerView.swift
//  WorkoutScheduler
//
//  Created by 土橋正晴 on 2025/05/02.
//

import SwiftUI

struct TimerView: View {
    
    @State private var timer = TimerObject()
    
    @State var workout: Workout
    
    @State var isSetTime: Bool = false
    
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
                
                dispTime
                
            }
            .padding()
            
            Form() {
                timeSetSection
                buttonSection
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
    
    private var timeSetSection: some View {
        Section {
            Toggle(isOn: $isSetTime, label: {
                Text(LocalizeString.Label.localized("EditTime"))
            })
            if isSetTime {
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
    }
    
    private var buttonSection: some View {
        Section {
            HStack(alignment: .center) {
                Button("Cancel") {
                    timer.invalidate()
                    timer.displayMin = workout.workoutMin
                    timer.displaySec = workout.workoutSec
                    timer.progresValue = 0
                    timer.status = .Start
                }
                .buttonStyle(.borderedProminent)
                .disabled(timer.status == .Start)
                
                Spacer()
                
                Button("\(timer.status.rawValue)") {
                    switch timer.status {
                    case .Start, .Resume:
                        timer.startTimer(setMin: workout.workoutMin, setSec: workout.workoutSec)
                    case .Pause:
                        timer.invalidate()
                        timer.status = .Resume
                    }
                }
                .buttonStyle(.borderedProminent)
                .disabled(workout.workoutMin == 0 && workout.workoutSec == 0)
            }
        }
    }

}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        TimerView(workout: Workout())
    }
}
