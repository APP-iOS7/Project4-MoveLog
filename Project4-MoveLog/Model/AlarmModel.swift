//
//  AlarmModel.swift
//  Project4-MoveLog
//
//  Created by 강보현 on 2/6/25.
//


import SwiftUI

struct AlarmModel: Identifiable, Codable {
    let id: UUID
    let hour: Int
    let minute: Int
    let period: String
    let days: [String]
    let sound: String

    init(id: UUID = UUID(), hour: Int, minute: Int, period: String, days: [String], sound: String) {
        self.id = id
        self.hour = hour
        self.minute = minute
        self.period = period
        self.days = days
        self.sound = sound
    }
}
