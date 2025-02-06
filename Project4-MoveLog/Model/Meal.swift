//
//  Meal.swift
//  Project4-MoveLog
//
//  Created by 강보현 on 2/4/25.
//

import Foundation
import SwiftData

@Model
final class Meal {
    var id: UUID = UUID()
    var name: String
    var calories: Int
    var date: Date
    
    init(name: String, calories: Int, date: Date) {
        self.name = name
        self.calories = calories
        self.date = date
    }
}
