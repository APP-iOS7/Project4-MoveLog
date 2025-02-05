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
            MyWorkout.self,
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
        let today = Date().startOfDay()
        
        let workoutList: [(String, WorkoutType)] = [
            ("Running", WorkoutType.cardio),
            ("Cycling", WorkoutType.cardio),
            ("Swimming", WorkoutType.cardio),
            ("Running11111", WorkoutType.upperBody),
            ("Running22222", WorkoutType.others),
            ("운동이름을 길다고 할만한게", WorkoutType.upperBody),
        ]
        
        let mealList: [(String, Int, Date)] = [("삼겹살", 1000, today), ("회", 1000, today),("과자", 1000, today),]
        
        let context = container.mainContext
        var savedWorkouts: [Workout] = []
        for (name, workoutType) in workoutList {
            let workout = Workout(name: name, type: workoutType)
            context.insert(workout)
            savedWorkouts.append(workout) // 나중에 MyWorkout에 연결할 수 있도록 저장
        }
        
        for (name, calories, date) in mealList {
            let meal = Meal(name: name, calories: calories, date: date)
            context.insert(meal)
        }
        for workout in savedWorkouts {
            let myWorkout = MyWorkout(workout: workout, date: today, duration: 1000, burnedCalories: 100.0)
            context.insert(myWorkout)
        }
        do {
            try context.save()
            print("더미 데이터 저장 완료 (Workout 개수: \(try context.fetch(FetchDescriptor<Workout>()).count))")
        } catch {
            print("Failed to save context: \(error)")
        }
    }
    
}
