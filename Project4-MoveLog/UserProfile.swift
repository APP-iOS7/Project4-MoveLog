//
//  Users.swift
//  Project4-MoveLog
//
//  Created by 강보현 on 2/5/25.
//

import SwiftData
import Foundation

enum Gender: String, Codable, CaseIterable {
    case male = "남성"
    case female = "여성"
}

@Model
class UserProfile {
    var gender: Gender
    var age: Int
    var height: Double  // cm 단위
    var weight: Double  // kg 단위
    var bmr: Double     // 기초대사량

    init(gender: Gender, age: Int, height: Double, weight: Double) {
        self.gender = gender
        self.age = age
        self.height = height
        self.weight = weight
        self.bmr = UserProfile.calculateBMR(gender: gender, age: age, height: height, weight: weight)
    }
    
    func updateProfile(age: Int, height: Double, weight: Double) {
        self.age = age
        self.height = height
        self.weight = weight
        self.bmr = UserProfile.calculateBMR(gender: gender, age: age, height: height, weight: weight)
    }

    static func calculateBMR(gender: Gender, age: Int, height: Double, weight: Double) -> Double {
        if gender == .male {
            return 88.36 + (13.4 * weight) + (4.8 * height) - (5.7 * Double(age))
        } else {
            return 447.6 + (9.2 * weight) + (3.1 * height) - (4.3 * Double(age))
        }
    }
}
