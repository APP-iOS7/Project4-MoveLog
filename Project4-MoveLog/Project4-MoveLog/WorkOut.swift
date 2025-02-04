//
//  WorkOut.swift
//  Project4-MoveLog
//
//  Created by SG on 2/4/25.
//

import Foundation
import SwiftUI

struct WorkOut: Identifiable {
    let id = UUID()
    var name: String
    var category: String // "하체", "상체", "유산소"
    var sets: Int?
    var weight: Int?
    var reps: Int?
    var time: (hours: Int, minutes: Int, seconds: Int)? // 유산소 운동 시간
    var kcal: Int
}
