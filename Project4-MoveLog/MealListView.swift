//
//  MealListView.swift
//  Project4-MoveLog
//
//  Created by SG on 2/5/25.
//

import SwiftUI
import SwiftData

struct MealListView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @Query private var meals: [Meal]  // 전체 운동 목록을 불러옴
    @State private var searchText = "" // 검색어 상태
    @State private var selectedMeal: Meal? //  선택된 운동 저장
    
    //    @State private var protein: Int = 0
    //    @State private var carbohydrates: Int = 0
    //    @State private var fat: Int = 0
    
    var filteredMeals: [Meal] {
        if searchText.isEmpty {
            return meals
        } else {
            return meals.filter { $0.name.contains(searchText) }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                // 검색창
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("검색 창", text: $searchText)
                }
                .padding()
                .background(Color.gray.opacity(0.3))
                .cornerRadius(10)
                .padding(.horizontal)
                // 운동 리스트
                List {
                    ForEach(filteredMeals) { meal in
                        HStack {
//                            Text(meal.id.uuidString)
                            Text(meal.name)
                                .font(.title3)
                            
                            Text("\(meal.calories) kcal")
                                .font(.caption)
                                .foregroundColor(.gray)
                            
                            //                            Text("\(meal.protein) kcal")
                            //                                .font(.caption)
                            //                                .foregroundColor(.gray)
                            Spacer()
                        }
                        .padding(.vertical, 5)
                        .contentShape(Rectangle())
                        .onTapGesture {
                            selectedMeal = meal
                        }
                        
                    }
                    
                    .onDelete(perform: deleteItems)
                }
                .background(Color.gray.opacity(0.3))
                .cornerRadius(20)
                .padding()
            }
            .padding(.horizontal, 20)
            .navigationTitle("식단 목록")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: MealEditView(meals: Meal(name: "새 음식", calories: 0, date: Date()))) {
                        Text("추가")
                    }
                }
            }
            .navigationDestination(isPresented: Binding(
                get: { selectedMeal != nil },
                set: { if !$0 { selectedMeal = nil } }
            )) {
                if let meals = selectedMeal {
                    MealEditView(meals: meals)
                }
            }
        }
        
        
        
    }
    
    
    /// 운동 삭제 함수
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(meals[index])
            }
        }
    }
}


#Preview {
    MealListView()
        .modelContainer(PreviewContainer.shared.container)
}
