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
            Text(meal.name)
            Text("\(meal.calories)")
        }
        .foregroundStyle(Color("textColor"))
        .frame(maxWidth: .infinity, minHeight: 50) // maxWidth 사용
            .background(Color("subColor"))
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}

#Preview {
    MealRowView(meal: Meal(name: "밥", calories: 200, date: Date()))
}
