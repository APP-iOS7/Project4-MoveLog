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
    @Query private var workout: [Workout]
    @Query private var meal: [Meal]
    
    private var workoutForSelectedDate: [Workout] {
        workout.filter { item in
            Calendar.current.isDate(item.date, inSameDayAs: selectedDate)
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
                    Spacer(minLength: 30)
                    RoundedRectangle(cornerRadius: 10).fill(Color("subColor")).frame(width: .infinity, height: 150)
                    Spacer(minLength: 50)
                    VStack {
                        Text("운동 기록")
                            .font(.title2)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundStyle(Color("textColor"))
                        if workoutForSelectedDate.isEmpty {
                            Text("운동 기록이 없습니다!")
                        }else {
                            ForEach(workoutForSelectedDate) { workout in
                                WorkoutRowView(workout: workout)
                            }
                        }
                        
                        
                    }
                    Spacer(minLength: 50)
                    VStack {
                        Text("식단 기록")
                            .font(.title2)
                            .fontWeight(.bold)
                            .frame(maxWidth: .infinity, alignment: .leading)
                            .foregroundStyle(Color("textColor"))
                        
                        if mealForSelectedDate.isEmpty {
                            Text("식단 기록이 없습니다!")
                        }else {
                            
                            
                            ForEach(mealForSelectedDate) { meal in
                                MealRowView(meal: meal)
                            }
                        }
                        
                    }
                    Spacer(minLength: 50)
                    NavigationLink(destination: WorkoutRecordsView()) {
                        Text("START")
                            .font(.largeTitle)
                            .frame(maxWidth: .infinity, minHeight: 50)
                            .foregroundStyle(Color("textColor"))
                            .background(Color("mainColor"))
                            .clipShape(RoundedRectangle(cornerRadius: 10))

                    }
                }
                .navigationTitle("무브로그")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        NavigationLink(destination: AlarmSettingsView()) {
                            Image(systemName: "bell")
                        }
                    }
                }
            }
            .padding()
        }
        .onAppear {
//            print("📆 현재 선택된 날짜: \(selectedDate)")
//
//            Task {
//                do {
//                    let allMeals = try modelContext.fetch(FetchDescriptor<Meal>())
//                    print("💾 저장된 Meal 개수: \(allMeals.count)")
//                    
//                    for meal in allMeals {
//                        print("🍽 Meal - 이름: \(meal.name), 날짜: \(meal.date)")
//                    }
//                } catch {
//                    print("❌ Meal 데이터 가져오기 실패: \(error)")
//                }
//            }
        }

    }
    
}

#Preview {
    ContentView()
        .modelContainer(PreviewContainer.shared.container)
}


