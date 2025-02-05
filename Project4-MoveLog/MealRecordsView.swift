//
//  MealRecordsView.swift
//  Project4-MoveLog
//
//  Created by SG on 2/5/25.
//

import SwiftUI
import SwiftData

struct MealRecordsView: View {
    @Query private var meals: [Meal]
    @State private var selectedMeal: Meal?

    var body: some View {
        NavigationStack {
            VStack {
                
                HStack {
                    Text("식단 종류")
                        .font(.title2)
                        .fontWeight(.bold)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .foregroundStyle(Color("textColor"))
                    NavigationLink(destination: MealListView()) {
                        Text("식단추가")
                            .frame(maxWidth: 100, minHeight: 30)
                            .foregroundStyle(Color("textColor"))
                            .background(Color("mainColor"))
                            .clipShape(RoundedRectangle(cornerRadius: 10))
                        
                    }
                }
                
                HStack {
                 
                    Picker("식단 선택", selection: $selectedMeal) {
                        // 먼저 비어있는 항목을 추가
                        Text("선택").tag(nil as Meal?)
                        
                        // 필터링된 운동 목록이 있을 경우에만 표시
                        if !meals.isEmpty {
                            ForEach(meals, id: \.self) { Meal in
                                Text(Meal.name).tag(Meal as Meal?)
                            }
                        }
                    }
                    .pickerStyle(.menu)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .foregroundStyle(Color("textColor"))
                    .tint(Color("textColor"))
//                    .onChange(of: selectedType) { oldValue, newValue in
//                        selectedWorkout = nil
//                    }
//                    .onAppear {
//                        selectedWorkout = nil
//                    }
                }
                
                Text("칼로리")
                    .font(.title2)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(Color("textColor"))
                
                    Spacer()
                
            }
            .padding()
        }
        
    }
}

#Preview {
    MealRecordsView()
        .modelContainer(PreviewContainer.shared.container)
}

