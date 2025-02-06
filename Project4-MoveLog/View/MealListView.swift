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

    @Query private var meals: [Meal]  // 전체 음식 목록을 불러옴
    @State private var searchText = "" // 검색어 상태

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
                // 음식 리스트
                List {
                    ForEach(filteredMeals) { meal in
                        NavigationLink {
                            MealEditView(meals: meal)
                        } label: {
                            HStack {
                                Text(meal.name)
                                    .font(.title3)

                                Text("\(meal.calories) kcal")
                                    .font(.caption)
                                    .foregroundColor(.gray)
                            }
                            .padding(.vertical, 6)
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
                .background(Color(red: 0.678, green: 0.973, blue: 0.424).opacity(0.3))
                .cornerRadius(20)
                .padding()
            }
            .padding(.horizontal, 20)
            .navigationTitle("식단 목록")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: MealAddView()) {
                        Text("추가")
                    }
                }
            }
        }
    }

    /// 음식 삭제 함수
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
