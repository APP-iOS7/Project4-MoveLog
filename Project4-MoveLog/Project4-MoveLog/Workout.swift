//
//  Workout.swift
//  Project4-MoveLog
//
//  Created by 강보현 on 2/4/25.
//

import Foundation
import SwiftData

@Model
final class Workout {
    var id: UUID = UUID()
    var name: String // 운동 이름 (예: '달리기')
    var duration: Int // 운동 시간 (초 단위)
    var caloriesBurned: Int // 소모한 칼로리
    var date: Date // 운동한 날짜
    
    init (name: String, duration: Int, caloriesBurned: Int, date: Date) {
        self.name = name
        self.duration = duration
        self.caloriesBurned = caloriesBurned
        self.date = date
    }
}
