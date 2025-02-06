//
//  MealEditView.swift
//  Project4-MoveLog
//
//  Created by SG on 2/5/25.
//

import SwiftUI
import SwiftData

struct MealEditView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    @State var selectedDate: Date
    let meals: Meal
    @State private var name: String = ""
    @State private var calories: Int = 0
    
    init(meals: Meal) {
        self.meals = meals
        _name = State(initialValue: meals.name)
        _calories = State(initialValue: meals.calories)
        _selectedDate = State(initialValue: meals.date)
    }
    
    
    var body: some View {
        NavigationStack {
            Spacer()
            Form {
                TextField("음식 이름", text: $name)
                    .padding(.vertical , 5)
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.gray.opacity(0.4))
                    .cornerRadius(8)
                
                HStack {
                    Text("칼로리")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Spacer()
                    TextField("칼로리", value: $calories, formatter: NumberFormatter())
                        .fontWeight(.bold)
                        .multilineTextAlignment(.trailing)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.gray.opacity(0.4))
                        .cornerRadius(8)
                    ValueBox(unit: "kcal")
                }
                Button("삭제 하기") {
                    modelContext.delete(meals)
                    dismiss()
                }
                .font(.title2)
                .fontWeight(.bold)
                .frame(maxWidth: .infinity, alignment: .trailing)
                .foregroundStyle(Color.red)
            }
            .background(Color.gray.opacity(0.3))
            .cornerRadius(12)
            .padding(.horizontal, 20)
            
        }
        
        Spacer()
            .navigationTitle("식단 작성")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("저장") {
                        meals.name = name
                        meals.calories = calories
                        meals.date = selectedDate
                        modelContext.insert(meals)
                        try? modelContext.save()
                        dismiss()
                    }
                }
            }
    }
}


#Preview {
    MealEditView(meals: Meal(name: "밥", calories: 100, date: Date()))
}
