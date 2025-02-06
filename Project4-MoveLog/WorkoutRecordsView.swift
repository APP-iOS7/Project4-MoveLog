//
//  WorkoutRecords.swift
//  Project4-MoveLog
//
//  Created by 강보현 on 2/4/25.
//

import SwiftUI
import SwiftData

struct WorkoutRecordsView: View {
    @Query private var workouts: [Workout]
    
    @State private var selectedWorkout: Workout?
    @State private var selectedType: WorkoutType = .cardio
    
    @State private var stoppedTime: TimeInterval = 0
    private var filteredWorkouts: [Workout] {
        workouts.filter { $0.type == selectedType }
    }
    var body: some View {
        NavigationStack {
            VStack {
                Text("타이머")
                    .font(.title2)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(Color("TextColor"))
                StopwatchView(stoppedTime: $stoppedTime) // `@Binding` 전달
                Spacer()
                HStack {
                    Text("운동 종류")
                        .font(.title2)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(Color("TextColor"))
                    NavigationLink(destination: WorkoutListView()) {
                        Text("운동추가")
                            .frame(maxWidth: 100, minHeight: 30)
                            .foregroundStyle(Color("TextColor"))
                            .background(Color("MainColor"))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                    }
                }
                
                HStack {
                    Picker("운동 유형", selection: $selectedType) {
                        ForEach(WorkoutType.allCases, id: \.self) { type in
                            Text(type.rawValue).tag(type)
                        }
                    }
                    .pickerStyle(.menu)
                    .frame(width: 150, alignment: .leading)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .foregroundStyle(Color("TextColor"))
                    .tint(Color("TextColor"))
                    Picker("운동 선택", selection: $selectedWorkout) {
                        // 먼저 비어있는 항목을 추가
                        Text("선택").tag(nil as Workout?)
                        
                        // 필터링된 운동 목록이 있을 경우에만 표시
                        if !filteredWorkouts.isEmpty {
                            ForEach(filteredWorkouts, id: \.self) { workout in
                                Text(workout.name).tag(workout as Workout?)
                            }
                        }
                    }
                    .pickerStyle(.menu)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .foregroundStyle(Color("TextColor"))
                    .tint(Color("TextColor"))
                    .onChange(of: selectedType) { oldValue, newValue in
                        selectedWorkout = nil
                    }
                    .onAppear {
                        selectedWorkout = nil
                    }
                }
                Spacer()
                
                Text("운동 시간")
                    .font(.title2)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(Color("TextColor"))
                Text(formatTime(stoppedTime))
                    .font(.title2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                
            
                Spacer()
                Text("칼로리")
                    .font(.title2)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(Color("TextColor"))
                
            }
            .padding()
        }
        
    }
}

private func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        let milliseconds = Int((time * 100).truncatingRemainder(dividingBy: 100))
        return String(format: "%02d:%02d:%02d", minutes, seconds, milliseconds)
    }

#Preview {
    WorkoutRecordsView()
        .modelContainer(PreviewContainer.shared.container)
}
