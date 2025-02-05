//
//  Workout.swift
//  Project4-MoveLog
//
//  Created by 강보현 on 2/4/25.
//

import Foundation
import SwiftData

enum WorkoutType: String, Codable, CaseIterable {
    case cardio = "유산소"
    case upperBody = "상체"
    case lowerBody = "하체"
    case others = "기타"
}

@Model
final class Workout {
    var id: UUID = UUID()
    var name: String // 운동 이름
    var duration: Int // 운동 시간 (초 단위)
    var caloriesBurned: Int // 소모한 칼로리
    var date: Date // 운동한 날짜
    var type: WorkoutType // 운동 유형

    
    init (name: String, duration: Int, caloriesBurned: Int, date: Date, type: WorkoutType) {
        self.name = name
        self.duration = duration
        self.caloriesBurned = caloriesBurned
        self.date = date
        self.type = type
    }

}
