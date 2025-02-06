//
//  Workout.swift
//  Project4-MoveLog
//
//  Created by 강보현 on 2/4/25.
//

import Foundation
import SwiftData

enum WorkoutType: String, Codable, CaseIterable, Equatable {
    case cardio = "유산소"
    case upperBody = "상체"
    case lowerBody = "하체"
    case others = "기타"
}

@Model
final class Workout {
    var name: String // 운동 이름
    var type: WorkoutType // 운동 유형

    
    init (name: String, type: WorkoutType) {
        self.name = name
        self.type = type
    }

}
