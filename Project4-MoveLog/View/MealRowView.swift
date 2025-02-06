//
//  MealRowView.swift
//  Project4-MoveLog
//
//  Created by 강보현 on 2/4/25.
//

import SwiftUI

struct MealRowView: View {
    let meal: Meal
    
    init(meal: Meal) {
        self.meal = meal
    }
    var body: some View {
        HStack(spacing: 10){
            Text(meal.name)
                .frame(width: 100, alignment: .leading)
                .lineLimit(1)
            Spacer()
            Text("\(meal.calories) kcal")
                .frame(alignment: .leading)
                .lineLimit(1)
        }
        .foregroundStyle(Color("textColor"))
        .font(.system(size: 15))
        .padding(.vertical, 5)
        .padding(.horizontal, 10)
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    MealRowView(meal: Meal(name: "밥", calories: 200, date: Date()))
}
