//
//  ContentView.swift
//  Project4-MoveLog
//
//  Created by 강보현 on 2/4/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var selectedDate: Date = Date()
    @State private var isFromNotification = false // 앱 실행 시 알람 클릭 여부 추적
    @State private var notificationExercise: ExerciseModel?
    @State private var showAlarmView = false
    
    @Query private var myWorkout: [MyWorkout]
    @Query private var meal: [Meal]
    @State private var userProfile: UserProfile?
    @State private var showUserInfo = false
    
    private var totalMealCalories: Int {
        mealForSelectedDate.reduce(0) { $0 + $1.calories }
    }
    
    private var totalBurnedCalories: Int {
        Int(workoutForSelectedDate.reduce(0) { $0 + $1.burnedCalories })
    }
    
    var workoutForSelectedDate: [MyWorkout] {
        myWorkout.filter { item in
            let selectedDay = selectedDate.startOfDay()
            return Calendar.current.isDate(item.date, inSameDayAs: selectedDay)
        }
    }
    
    private var mealForSelectedDate: [Meal] {
        meal.filter { item in
            Calendar.current.isDate(item.date, inSameDayAs: selectedDate)
        }
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                VStack{
                    DatePicker("Select Date", selection: $selectedDate, displayedComponents: [.date])
                        .datePickerStyle(.graphical)
                        .background(Color.gray.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .tint(Color("mainColor"))
                    Spacer(minLength: 30)
                    HStack {
                        Text("칼로리 소비량")
                            .font(.title2)
                            .fontWeight(.bold)
                            .foregroundStyle(Color("textColor"))
                        Spacer(minLength: 30)
                        if let profile = userProfile {
                            if showUserInfo {
                                VStack {
                                    HStack {
                                        Text("\(profile.gender.rawValue) | \(profile.height, specifier: "%.1f")cm | \(profile.weight, specifier: "%.1f")kg")
                                        Spacer()
                                    }
                                    HStack {
                                        Text("BMR: \(profile.bmr, specifier: "%.1f") kcal")
                                        Spacer()
                                    }
                                }
                                .font(.footnote)
                                .foregroundStyle(Color("textColor"))
                                .transition(.opacity)
                            }
                        }
                        else {
                            Text("사용자 정보가 없습니다!")
                        }
                        Spacer()
                        
                        
                        Button(action: {
                            withAnimation {
                                showUserInfo.toggle()
                            }
                        }) {
                            Image(systemName: !showUserInfo ? "eye.slash" : "eye")
                                .foregroundStyle(Color("textColor"))
                        }
                    }
                    .padding(.horizontal, 2)
                    Spacer(minLength: 16)
                    VStack(alignment: .leading, spacing: 8) { // 간격 조정
                        HStack {
                            Text(" ") // 공백 문자 추가
                                .frame(width: 20) // 이모지 크기만큼 너비 지정
                            Text("식사: \(totalMealCalories) kcal")
                        }
                        .padding(.vertical, 8)
                        .padding(.horizontal, 8)
                        HStack {
                            //수평 선
                            let totalBurnedCalories = workoutForSelectedDate.reduce(0) { $0 + $1.burnedCalories }
                            
                            Text("➖ 운동 소모 칼로리: \(totalBurnedCalories, specifier: "%.1f") kcal")
                        }
                        .padding(.horizontal, 8)
                        Divider() // 검은색 구분선
                            .background(Color("textColor"))
                            .padding(8)
                        HStack {
                            Text(" ") // 공백 문자 추가
                                .frame(width: 20) // 이모지 크기만큼 너비 지정
                            let totalCalories = totalMealCalories - totalBurnedCalories
                            if totalCalories > 0 {
                                Text("결과 : \(totalCalories) kcal")
                                    .foregroundStyle(Color.red)
                            } else {
                                Text("결과 : \(totalCalories) kcal")
                                    .foregroundStyle(Color.blue)
                            }
                        }
                        .padding(EdgeInsets(top: 0, leading: 8, bottom: 16, trailing: 16))
                    }
                    .background(Color.gray.opacity(0.1))
                    .foregroundStyle(Color("textColor"))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .padding(.horizontal, 2)
                    Spacer(minLength: 30)
                    VStack {
                        HStack {
                            Text("운동 기록")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundStyle(Color("textColor"))
                            Spacer()
                            NavigationLink(destination: WorkoutRecordsView()) {
                                Text("운동 추가")
                                    .font(.system(size: 15))
                                    .foregroundStyle(Color.white)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 5)
                                    .background(Color("mainColor"))
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                        }
                        .padding(.horizontal, 2)
                        
                        VStack {
                            if workoutForSelectedDate.isEmpty {
                                HStack {
                                    Spacer()
                                    Text("운동 기록이 없습니다!")
                                        .padding()
                                    Spacer()
                                }
                                
                            } else {
                                ForEach(workoutForSelectedDate) { myWorkout in
                                    WorkoutRowView(myWorkout: myWorkout)
                                }
                            }
                        }
                        .background(Color.gray.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    
                    Spacer(minLength: 50)
                    VStack {
                        HStack {
                            Text("식단 기록")
                                .font(.title2)
                                .fontWeight(.bold)
                                .foregroundStyle(Color("textColor"))
                            Spacer()
                            NavigationLink(destination: MealRecordsView(selectedDate: selectedDate)) {
                                Text("식단 추가")
                                    .font(.system(size: 15))
                                    .foregroundStyle(Color.white)
                                    .padding(.horizontal, 10)
                                    .padding(.vertical, 5)
                                    .background(Color("mainColor"))
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                        }
                        .padding(.horizontal, 2)
                        
                        VStack {
                            if mealForSelectedDate.isEmpty {
                                HStack {
                                    Spacer()
                                    Text("식단 기록이 없습니다!")
                                        .padding()
                                    Spacer()
                                }
                            }else {
                                ForEach(mealForSelectedDate) { meal in
                                    MealRowView(meal: meal)
                                }
                            }
                        }
                        .background(Color.gray.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
                .toolbar {
                    ToolbarItem(placement: .topBarLeading) {
                        HStack {
                            Image("icon")
                                .resizable()
                                .frame(width: 40, height: 30)
                            Text("무브로그")
                                .font(.title)
                                .bold()
                                .foregroundColor(.black)
                        }
                        
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink {
                            UserProfileView()
                        }
                        label: {
                            Image(systemName: "person.circle")
                                .foregroundStyle(Color.black.opacity(1))
                        }
                    }
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: AlarmSettingsView()) {
                            Image(systemName: "bell")
                                .foregroundStyle(Color.black.opacity(1))
                        }
                    }
                }
                .onAppear {
                    loadUserProfile()
                    
                    Task {
                        await NotificationManager.shared.requestAuthorization()
                    }
                    NotificationCenter.default.addObserver(forName: NSNotification.Name("OpenAlarmView"), object: nil, queue: .main) { notification in
                        print("📢 OpenAlarmView 알림 수신!")
                        if let userInfo = notification.userInfo {
                            self.showAlarmView = true
                            print("userInfo : \(userInfo)")
                        }
                        else {
                            print("⚠️ userInfo에 데이터 없음")
                        }
                        self.isFromNotification = true
                    }
                }
                .sheet(isPresented: $showAlarmView) {
                    ExerciseAlarmView(exercise: ExerciseModel.randomExercise())
                }
            }
            .padding()
        }
    }
    
    private func loadUserProfile() {
        Task {
            do {
                let fetchDescriptor = FetchDescriptor<UserProfile>()
                let profiles = try modelContext.fetch(fetchDescriptor)
                self.userProfile = profiles.first
            } catch {
                print("프로필 로드 실패: \(error)")
            }
        }
    }
    
}

extension Date {
    func startOfDay() -> Date {
        return Calendar.current.startOfDay(for: self)
    }
}

#Preview {
    ContentView()
        .modelContainer(PreviewContainer.shared.container)
}

