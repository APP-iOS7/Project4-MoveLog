//
//  WorkoutRowView.swift
//  Project4-MoveLog
//
//  Created by 강보현 on 2/4/25.
//

import Foundation
import SwiftUI

struct WorkoutRowView: View {
    let myWorkout: MyWorkout

    init(myWorkout: MyWorkout) {
        self.myWorkout = myWorkout
    }
    
    var body: some View {
        HStack(spacing: 20) {
            Text(myWorkout.workout.name)
                .frame(width: 100, alignment: .leading)
                .lineLimit(1)
            Text("\(myWorkout.duration.formattedDuration())")
                .frame(width: 100, alignment: .leading)
                .lineLimit(1)
            Text("\(myWorkout.burnedCalories.formattedCalories())")
                .frame(width: 100, alignment: .leading)
                .lineLimit(1)
        }
        .foregroundStyle(Color("textColor"))
        .frame(maxWidth: .infinity, minHeight: 50)
//        .background(Color.gray.opacity(0.1))
        .clipShape(RoundedRectangle(cornerRadius: 10))

    }
}

extension TimeInterval {
    func formattedDuration() -> String {
        let hours = Int(self) / 3600
        let minutes = (Int(self) % 3600) / 60
        let seconds = Int(self) % 60
        
        if hours > 0 {
            return String(format: "%02d시간 %02d분 %02d초", hours, minutes, seconds)
        } else if minutes > 0 {
            return String(format: "%02d분 %02d초", minutes, seconds)
        } else {
            return String(format: "00분 %02d초", seconds)
        }
    }
}
extension Double {
    func formattedCalories() -> String {
        return String(format: "%.1f kcal", self)
    }
}

#Preview {
    WorkoutRowView(myWorkout: MyWorkout(workout: Workout(name: "벤치", type: .lowerBody), date: Date(), duration: 1000, burnedCalories: 1000.0))
}
