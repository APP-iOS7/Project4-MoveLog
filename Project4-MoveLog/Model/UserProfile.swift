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
    var height: Double  // cm
    var weight: Double  // kg
    var bmr: Double     // 기초대사량
    
    /// **UserProfile 생성자**
    /// - 사용자의 성별, 나이, 키, 몸무게를 입력받아 초기화
    /// - BMR(기초대사량) 값은 자동으로 계산됨
    init(gender: Gender, age: Int, height: Double, weight: Double) {
        self.gender = gender
        self.age = age
        self.height = height
        self.weight = weight
        self.bmr = UserProfile.calculateBMR(gender: gender, age: age, height: height, weight: weight)
    }
    
    /// /// **사용자 프로필 업데이트 함수**
    /// - 사용자의 나이, 키, 몸무게가 변경될 경우 업데이트
    /// - BMR(기초대사량)도 다시 계산됨
    func updateProfile(age: Int, height: Double, weight: Double) {
        self.age = age
        self.height = height
        self.weight = weight
        self.bmr = UserProfile.calculateBMR(gender: gender, age: age, height: height, weight: weight)
    }
    /// **기초대사량(BMR) 계산 함수**
    /// - 성별에 따라 다른 공식 적용
    static func calculateBMR(gender: Gender, age: Int, height: Double, weight: Double) -> Double {
        if gender == .male {
            return 88.36 + (13.4 * weight) + (4.8 * height) - (5.7 * Double(age))
        } else {
            return 447.6 + (9.2 * weight) + (3.1 * height) - (4.3 * Double(age))
        }
    }
}
