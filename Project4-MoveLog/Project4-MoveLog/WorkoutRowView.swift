//
//  WorkoutRowView.swift
//  Project4-MoveLog
//
//  Created by 강보현 on 2/4/25.
//

import Foundation
import SwiftUI

struct WorkoutRowView: View {
    let workout: Workout
    
    init(workout: Workout) {
        self.workout = workout
    }
    
    var body: some View {
        HStack {
            Text(workout.name)
                .padding()
            Text("\(workout.duration)")
            Text("\(workout.caloriesBurned) kcal")
                .padding()
        }
        .foregroundStyle(Color("textColor"))
        .frame(maxWidth: .infinity, minHeight: 50) // maxWidth 사용
            .background(Color("subColor"))
            .clipShape(RoundedRectangle(cornerRadius: 10))


    }
}
#Preview {
    WorkoutRowView(
        workout: Workout(
            name: "달리기",
            duration: 1800, // 30분
            caloriesBurned: 250,
            date: Date()
        )
    )
}
