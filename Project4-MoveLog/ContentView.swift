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
                        .background(Color.gray.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .tint(Color("CalendarColor"))
                    Spacer(minLength: 30)
                    Text("칼로리 소비량")
                        .font(.title2)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(Color("textColor"))
                    VStack(alignment: .leading, spacing: 8) { // 간격 조정
                        Text("식사 kcal")
                        Text(" - 전체 운동 kcal")
                        Divider() // 검은색 구분선
                            .background(Color("textColor"))
                        
                        Text(" kcal")
                            .font(.headline)
                    }
                    .padding()
                    .background(Color("subColor"))
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .foregroundStyle(Color("textColor"))
                    
                    Spacer(minLength: 50)
                    VStack {
                        HStack {
                            Text("운동 기록")
                                .font(.title2)
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundStyle(Color("textColor"))
                            NavigationLink(destination: WorkoutRecordsView()) {
                                Text("START")
                                    .font(.title2)
                                    .frame(maxWidth: .infinity, minHeight: 40)
                                    .foregroundStyle(Color("textColor"))
                                    .background(Color("mainColor"))
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                                
                            }
                        }
                        if workoutForSelectedDate.isEmpty {
                            Text("운동 기록이 없습니다!")
                        }else {
                            ForEach(workoutForSelectedDate) { workout in
                                WorkoutRowView(workout: workout)
                            }
                        }
                        Spacer(minLength: 50)
                        
                        
                    }
                    Spacer(minLength: 50)
                    VStack {
                        HStack {
                            Text("식단 기록")
                                .font(.title2)
                                .fontWeight(.bold)
                                .frame(maxWidth: .infinity, alignment: .leading)
                                .foregroundStyle(Color("textColor"))
                            NavigationLink(destination: MealRecordsView()) {
                                Text("식단 추가")
                                    .font(.title2)
                                    .frame(maxWidth: .infinity, minHeight: 40)
                                    .foregroundStyle(Color("textColor"))
                                    .background(Color("mainColor"))
                                    .clipShape(RoundedRectangle(cornerRadius: 10))
                            }
                        }
                        
                        if mealForSelectedDate.isEmpty {
                            Text("식단 기록이 없습니다!")
                        }else {
                            
                            
                            ForEach(mealForSelectedDate) { meal in
                                MealRowView(meal: meal)
                            }
                        }
                        
                    }
                }
                .navigationTitle("무브로그")
                .toolbar {
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


