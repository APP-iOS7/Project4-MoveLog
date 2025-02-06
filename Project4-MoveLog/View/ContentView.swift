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
    @Query private var myWorkout: [MyWorkout]
    @Query private var meal: [Meal]
    @Query private var user: [UserProfile]
    private var totalBurnedCalories = 0
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
                        .tint(Color("DarkColor"))
                        .frame(height: 400)
                    Spacer(minLength: 30)
                    Text("칼로리 소비량")
                        .font(.title2)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(Color("TextColor"))
                    VStack(alignment: .leading, spacing: 8) { // 간격 조정
                        HStack {
                            Text(" ") // 공백 문자 추가
                                .frame(width: 20) // 이모지 크기만큼 너비 지정
                            Text("식사: 2000 kcal")
                        }
                        HStack {
                            //수평 선
                            let totalBurnedCalories = workoutForSelectedDate.reduce(0) { $0 + $1.burnedCalories }
                            
                            Text("➖ 운동 소모 칼로리: \(totalBurnedCalories, specifier: "%.1f") kcal")
                        }
                        
                        Divider() // 검은색 구분선

                            .background(Color("TextColor"))
                        
                        Text(" kcal")
                            .font(.headline)

                    }
                    .padding()
                    .background(Color("SubColor"))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .foregroundStyle(Color("TextColor"))
                    
                    Spacer(minLength: 50)
                    VStack {
                        HStack {
                            Text("운동 기록")
                                .font(.title2)
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundStyle(Color("TextColor"))
                            NavigationLink(destination: WorkoutRecordsView()) {
                                Text("START")
                                    .font(.title2)
                                    .frame(maxWidth: .infinity, minHeight: 40)
                                    .foregroundStyle(Color("TextColor"))
                                    .background(Color("MainColor"))
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                        }
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
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.gray.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                    
                    Spacer(minLength: 50)
                    VStack {
                        HStack {
                            Text("식단 기록")
                                .font(.title2)
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundStyle(Color("TextColor"))
                            NavigationLink(destination: MealRecordsView(selectedDate: selectedDate)) {
                                Text("식단 추가")
                                    .font(.title2)
                                    .frame(maxWidth: .infinity, minHeight: 40)
                                    .foregroundStyle(Color("TextColor"))
                                    .background(Color("MainColor"))
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                        }
                        VStack {
                            if mealForSelectedDate.isEmpty {
                                Text("식단 기록이 없습니다!")
                                    .padding()
                            }else {
                                ForEach(mealForSelectedDate) { meal in
                                    MealRowView(meal: meal)
                                }
                            }
                        }
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.gray.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                    }
                }
                .navigationTitle("무브로그")
                .toolbar {
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
                        NavigationLink {
                            
                        }
                        label: {
                            Image(systemName: "bell")
                                .foregroundStyle(Color.black.opacity(1))
                        }
                    }
                }
            }
            .padding()
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


