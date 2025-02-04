//
//  PreviewContainer.swift
//  Project4-MoveLog
//
//  Created by 강보현 on 2/4/25.
//
import Foundation
import SwiftData

@MainActor
class PreviewContainer {
    static let shared: PreviewContainer = PreviewContainer()

    let container: ModelContainer
    
    init() {
        let schema = Schema([
            Workout.self,
            Meal.self
        ])
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        
        do {
            container = try ModelContainer(for: schema, configurations: [modelConfiguration])
            insertPreviewData()
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
    func insertPreviewData() {
        let today = Date()

        let workoutList: [(String, Int, Int, Date)] = [
            ("Running", 10, 100, today),
            ("Cycling", 20, 200, today),
            ("Swimming", 30, 300, today - 1000),
            ("Running11111", 10, 100, today),
            ("Running22222", 10, 100, today),
            ("Running33", 10, 100, today),
        ]
        
        let mealList: [(String, Int, Date)] = [("삼겹살", 1000, today), ("회", 1000, today),("과자", 1000, today),]

        let context = container.mainContext

        for (name, duration, caloriesBurned, date) in workoutList {
            let workout = Workout(name: name, duration: duration, caloriesBurned: caloriesBurned, date: date)
            context.insert(workout)
        }
        
        for (name, calories, date) in mealList {
            let meal = Meal(name: name, calories: calories, date: date)
            context.insert(meal)
        }

        do {
            try context.save()
            print("더미 데이터 저장 완료 (Workout 개수: \(try context.fetch(FetchDescriptor<Workout>()).count))")
        } catch {
            print("Failed to save context: \(error)")
        }
    }

}
