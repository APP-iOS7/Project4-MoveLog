//
//  MealEditView.swift
//  Project4-MoveLog
//
//  Created by SG on 2/5/25.
//

import SwiftUI

struct MealEditView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    let meals: Meal
    
    @State private var name: String = ""
    @State private var calories: Int = 0
//    @State private var mealid: String = ""
    

//    @State private var protein: Int = 0
//    @State private var carbohydrates: Int = 0
//    @State private var fat: Int = 0
    
    
    init(meals: Meal) {
        self.meals = meals
        _name = State(initialValue: meals.name)
        _calories = State(initialValue: meals.calories)
//        _mealid = (State(initialValue: meals.id.uuidString))
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
                    .background(Color(red: 0.843, green: 0.937, blue: 0.839).opacity(0.4)) // #d7efd6
                    .cornerRadius(8)
                
            
//                HStack {
//                    Text("탄수화물")
//                        .font(.caption)
//                        .foregroundColor(.gray)
//                    Spacer()
//                    TextField("탄수화물", value: $carbohydrates, formatter: NumberFormatter())
//                        
//                        .frame(width: 100)
//                            .fontWeight(.bold)
//                            .multilineTextAlignment(.trailing)
//                            .padding(.leading, 8)
//                            .padding(.vertical, 4)
//                            .background(Color(red: 0.843, green: 0.937, blue: 0.839).opacity(0.4))
//                            .cornerRadius(8)
//                    
//                    ValueBox(unit: "g")
//                }
//                HStack {
//                    Text("단백질")
//                        .font(.caption)
//                        .foregroundColor(.gray)
//                    Spacer()
//                    TextField("단백질", value: $protein, formatter: NumberFormatter())
//                        .frame(width: 100)
//                            .fontWeight(.bold)
//                            .multilineTextAlignment(.trailing)
//                            .padding(.leading, 8)
//                            .padding(.vertical, 4)
//                            .background(Color(red: 0.843, green: 0.937, blue: 0.839).opacity(0.4))
//                            .cornerRadius(8)
//                    ValueBox(unit: "g")
//                }
//                HStack {
//                    Text("지방")
//                        .font(.caption)
//                        .foregroundColor(.gray)
//                    Spacer()
//                    TextField("지방", value: $fat, formatter: NumberFormatter())
//                        .frame(width: 100)
//                            .fontWeight(.bold)
//                            .multilineTextAlignment(.trailing)
//                            .padding(.leading, 8)
//                            .padding(.vertical, 4)
//                            .background(Color(red: 0.843, green: 0.937, blue: 0.839).opacity(0.4))
//                            .cornerRadius(8)
//                    ValueBox(unit: "g")
//                }
                    
            
                HStack {
                    Text("칼로리")
                        .font(.caption)
                        .foregroundColor(.gray)
                    Spacer()
                    TextField("칼로리", value: $calories, formatter: NumberFormatter())
                        .frame(width: 100)
                            .fontWeight(.bold)
                            .multilineTextAlignment(.trailing)
                            .padding(.leading, 8)
                            .padding(.vertical, 4)
                            .background(Color(red: 0.843, green: 0.937, blue: 0.839).opacity(0.4))
                            .cornerRadius(8)
                    ValueBox(unit: "kcal")
                }
                
           
                
            }
            .scrollContentBackground(.hidden) 
            .background(Color(red: 0.678, green: 0.973, blue: 0.424).opacity(0.3)) // #adf86c
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
                            
                            modelContext.insert(meals)
                            try? modelContext.save()
                            dismiss()
                        }
                }
        }
    }
 
    
}


private struct ValueBox: View {
    var unit: String
    
    var body: some View {
        HStack {
            Text(unit)
                .font(.caption)
                .foregroundColor(.gray)
        }
    }
}



#Preview {
    MealEditView(meals: Meal(name: "밥", calories: 100, date: Date()))
}
