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
            Spacer()
            Text(workout.name)
                .frame(width: 100, alignment: .leading)
                .lineLimit(1)
            Spacer()
            Text("\(workout.duration)")
            
                .frame(width: 100, alignment: .leading)
                .lineLimit(1)
            Text("\(workout.caloriesBurned) kcal")
            
                .frame(width: 100, alignment: .leading)
                .lineLimit(1)
        }
        .foregroundStyle(Color("TextColor"))
        .frame(maxWidth: .infinity, minHeight: 50) // maxWidth 사용
            .background(Color("SubColor"))
            .clipShape(RoundedRectangle(cornerRadius: 10))


    }
}
#Preview {
    WorkoutRowView(
        workout: Workout(
            name: "달리기",
            duration: 1800, // 30분
            caloriesBurned: 250,
            date: Date(),
            type: .cardio
        )
    )
}
