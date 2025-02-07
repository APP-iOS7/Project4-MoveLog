//
//  PreviewContainer.swift
//  Project4-MoveLog
//
//  Created by 강보현 on 2/4/25.
//
import Foundation
import SwiftData

// 미리보기 환경에서 사용할 데이터 컨테이너
@MainActor
class PreviewContainer {
    /// `shared` 정적 프로퍼티를 사용하여 전역적으로 하나의 인스턴스만 생성
    static let shared: PreviewContainer = PreviewContainer()
    
    let container: ModelContainer
    /// 생성자: SwiftData Schema(모델 정의)를 설정하고, 샘플 데이터를 삽입
    init() {
        let schema = Schema([
            Workout.self,
            MyWorkout.self,
            Meal.self
        ])
        // 메모리에만 저장되는 데이터베이스 설정 (`isStoredInMemoryOnly: true`)
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: true)
        do {
            // SwiftData 컨테이너 생성 및 스키마 적용
            container = try ModelContainer(for: schema, configurations: [modelConfiguration])
            // 샘플 데이터 삽입
            insertPreviewData()
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }
    
    // 샘플 데이터를 SwiftData 컨테이너에 삽입하는 함수
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
        // Workout 데이터 추가
        for (name, workoutType) in workoutList {
            let workout = Workout(name: name, type: workoutType)
            context.insert(workout)
            savedWorkouts.append(workout) // 나중에 MyWorkout에 연결할 수 있도록 저장
        }
        // Meal 데이터 추가
        for (name, calories, date) in mealList {
            let meal = Meal(name: name, calories: calories, date: date)
            context.insert(meal)
        }
        // MyWorkout 데이터 추가 (운동 기록)
        for workout in savedWorkouts {
            let myWorkout = MyWorkout(workout: workout, date: today, duration: 1000, burnedCalories: 100.0)
            context.insert(myWorkout)
        }
        // 저장
        do {
            try context.save()
            print("더미 데이터 저장 완료 (Workout 개수: \(try context.fetch(FetchDescriptor<Workout>()).count))")
        } catch {
            print("Failed to save context: \(error)")
        }
    }
    
}
