//
//  MyWorkout.swift
//  Project4-MoveLog
//
//  Created by 강보현 on 2/5/25.
//

import Foundation
import SwiftData

@Model
final class MyWorkout {
    var workout: Workout  // 기존 Workout을 포함
    var date: Date        // 운동한 날짜
    var duration: TimeInterval
    var burnedCalories: Double

    init(workout: Workout, date: Date, duration: TimeInterval, burnedCalories: Double) {
        self.workout = workout
        self.date = date
        self.duration = duration
        self.burnedCalories = burnedCalories
    }
}

