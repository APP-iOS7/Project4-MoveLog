//
//  WorkoutRecords.swift
//  Project4-MoveLog
//
//  Created by 강보현 on 2/4/25.
//
import SwiftUI
import SwiftData

struct WorkoutRecordsView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) var dismiss
    
    @State private var workouts: [Workout] = []
    @State private var userProfile: [UserProfile] = []
    @State private var selectedWorkout: Workout?
    @State private var selectedType: WorkoutType = .cardio
    @State private var burnedCalories: Double = 0.0
    @State private var stoppedTime: TimeInterval = 0
    
    private var filteredWorkouts: [Workout] {
        workouts.filter { $0.type == selectedType }
    }
    private var user: UserProfile? {
        userProfile.first
    }
    var body: some View {
        NavigationStack {
            VStack {
                Text("타이머")
                    .font(.title2)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(Color("textColor"))
                StopwatchView(stoppedTime: $stoppedTime) // `@Binding` 전달
                Spacer()
                // 운동 유형 및 선택
                HStack {
                    Text("운동 종류")
                        .font(.title2)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(Color("textColor"))
                    NavigationLink(destination: WorkoutListView()) {
                        Text("운동추가")
                            .frame(maxWidth: 100, minHeight: 30)
                            .foregroundStyle(Color.white)
                            .background(Color("mainColor"))
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
                    .foregroundStyle(Color("textColor"))
                    .tint(Color("textColor"))
                    Picker("운동 선택", selection: $selectedWorkout) {
                        Text("선택").tag(nil as Workout?)
                        ForEach(filteredWorkouts, id: \.id) { workout in
                            Text(workout.name).tag(Optional(workout))
                        }
                    }
                    .pickerStyle(.menu)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .foregroundStyle(Color("textColor"))
                    .tint(Color("textColor"))
                    .onChange(of: selectedType) {
                        selectedWorkout = filteredWorkouts.first
                    }
                    .onAppear {
                        if selectedWorkout == nil, !filteredWorkouts.isEmpty {
                            selectedWorkout = filteredWorkouts.first
                        }
                    }
                }
                Spacer()
                Text("운동 시간")
                    .font(.title2)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(Color("textColor"))
                Text(formatTime(stoppedTime))
                    .font(.title2)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .padding()
                Spacer()
                Text("칼로리")
                    .font(.title2)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(Color("textColor"))
                    .onChange(of: stoppedTime) {
                        if let user = user {
                            burnedCalories = calculateBurnedCalories(user: user, stoppedTime: stoppedTime)
                        }
                    }
                if let user = user, let selectedWorkout = selectedWorkout {
                    Text("\(burnedCalories, specifier: "%.2f") kcal")
                } else if user == nil {
                    Text("프로필을 설정하세요").foregroundColor(.red)
                } else {
                    Text("운동을 선택하세요").foregroundColor(.gray)
                }
                Spacer()
                Button(action: {
                    guard let selectedWorkout = selectedWorkout else {
                        return
                    }
                    let myWorkout = MyWorkout(
                        workout: selectedWorkout,
                        date: Date().startOfDay(),
                        duration: stoppedTime,
                        burnedCalories: burnedCalories
                    )
                    modelContext.insert(myWorkout)
                    do {
                        try modelContext.save()
                    } catch {
                        print("저장 실패: \(error)")
                    }
                    dismiss()
                }, label: {
                    Text("저장하기")
                })
                .frame(maxWidth: .infinity, maxHeight: 50)
                .background(Color("mainColor"))
                .clipShape(RoundedRectangle(cornerRadius: 10))
                .foregroundStyle(Color.white)
            }
            .padding()
        }
        .onAppear {
            // 데이터 불러오기
            Task {
                do {
                    workouts = try modelContext.fetch(FetchDescriptor<Workout>())
                    userProfile = try modelContext.fetch(FetchDescriptor<UserProfile>())
                    print("불러온 운동 개수: \(workouts.count)")
                    print("불러온 유저 프로필 개수: \(userProfile.count)")
                    for workout in workouts {
                        print("운동 기록: \(workout.name), 유형: \(workout.type)")
                    }
                } catch {
                    print("데이터 가져오기 실패: \(error)")
                }
            }
        }
    }
}

func calculateBurnedCalories(user: UserProfile, stoppedTime: TimeInterval) -> Double {
    let bmrPerHour = user.bmr / 24
    let workoutTimeInHours = stoppedTime / 3600
    return bmrPerHour * workoutTimeInHours
}

private func formatTime(_ time: TimeInterval) -> String {
    let minutes = Int(time) / 60
    let seconds = Int(time) % 60
    return String(format: "%02d:%02d", minutes, seconds)
}
