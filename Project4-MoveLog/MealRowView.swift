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
        HStack {
        Spacer()
        Spacer()
            Text(meal.name)
                .frame(width: 200, alignment: .leading)
                .lineLimit(1)
            Spacer()
            Text("\(meal.calories) kcal")
                .frame(width: 100, alignment: .leading)
                .frame(width: 200, alignment: .leading)
                .lineLimit(1)
            Spacer()
            Text("\(meal.calories) kcal")
                .frame(width: 100, alignment: .leading)
        }
        .foregroundStyle(Color("TextColor"))
        .frame(maxWidth: .infinity, minHeight: 50) // maxWidth 사용
        .background(Color("SubColor"))
        .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    MealRowView(meal: Meal(name: "밥", calories: 200, date: Date()))
}
