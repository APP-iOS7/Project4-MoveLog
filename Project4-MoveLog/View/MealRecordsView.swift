//
//  MealRecordsView.swift
//  Project4-MoveLog
//
//  Created by SG on 2/5/25.
//

import SwiftUI
import SwiftData

struct MealRecordsView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @Query private var meal: [Meal]
    
    let selectedDate: Date
 
    private var mealForSelectedDate: [Meal] {
        meal.filter { item in
            Calendar.current.isDate(item.date, inSameDayAs: selectedDate)
        }
    }
    
    var body: some View {
        VStack {
            HStack {
                Text("식단 종류")
                    .font(.title2)
                    .fontWeight(.bold)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .foregroundStyle(Color("textColor"))
                NavigationLink(destination: MealAddView(selectedDate: selectedDate)) {
                    Text("식단추가")
                        .frame(maxWidth: 100, minHeight: 30)
                        .foregroundStyle(Color.white)
                        .background(Color("mainColor"))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
            
            List {
                ForEach(mealForSelectedDate, id: \.self) { meal in
                    NavigationLink {
                        MealEditView(meals: meal)
                    } label: {
                        HStack {
                            Text(meal.name)
                                .foregroundStyle(Color("textColor"))
                            Spacer()
                            Text("\(meal.calories) kcal")
                                .foregroundStyle(Color("textColor"))
                            
                        }
                    }
                }
            }
            .listStyle(PlainListStyle())
            Spacer()
        }
        .padding()
        .navigationTitle("식단 기록")
    }
}

#Preview {
    NavigationStack {
        MealRecordsView(selectedDate: Date())
            .modelContainer(PreviewContainer.shared.container)
    }
}
