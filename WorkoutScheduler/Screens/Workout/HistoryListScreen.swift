//
//  HistoryListScreen.swift
//  WorkoutTimer
//
//  Created by 土橋正晴 on 2025/09/21.
//

import SwiftUI
import SwiftData

struct HistoryListScreen: View {
    
    @State private var isShowSetting = false
    
    @AppStorage("historyMiniMin") private var dispMin: Int = 0
    
    var body: some View {
        NavigationStack {
            HistoryListView(dispMin: $dispMin)
                .navigationDestination(for: Workout.self, destination: {
                    WorkoutDetailScreen(workout: $0)
                })
                .toolbar {
                    ToolbarItem(placement: .topBarTrailing) {
                        IconButton(action: {
                            isShowSetting = true
                        }, iconName: .other(name: "gear"))
                    }
                }
                .sheet(isPresented: $isShowSetting) {
                    HistorySettingScreen()
                    
                }
        }
    }
}



struct HistoryListView: View {
    
    @Query private var historys: [History] = []
    
    @Environment(\.modelContext) private var modelContext
    
    @Binding private var dispMin: Int
    
    init(dispMin: Binding<Int>) {
        _dispMin = dispMin
        let wrappedValue = self.$dispMin.wrappedValue
        _historys = Query(
            filter: #Predicate { model in
                model.workoutData >= (60 * wrappedValue)
            },
            sort: [SortDescriptor(\History.created_at, order: .reverse)]
        )
    }
    
    var body: some View {
        ZStack {
            List {
                ForEach(historys) { history in
                    NavigationLink(value: history.workout, label: {
                        VStack(alignment: .leading) {
                            Text(history.workout?.name ?? "")
                            Text(history.timeElapsed())
                            Text(history.workoutTime())
                        }
                    })
                }
                .onDelete(perform: delete)
            }
            .navigationTitle("HistoryListScreen")
            
            if historys.isEmpty {
                Text(dispMin == 0 ? "NoHistory" : "NoHistoryTimeList \(dispMin)")
                    .font(.subheadline)
            }
        }
    }
    
    private func delete(at offsets: IndexSet) {
        for offset in offsets {
            let history = historys[offset]
            modelContext.delete(history)
            try? modelContext.save()
        }
    }
}


#Preview {
    HistoryListScreen()
}
