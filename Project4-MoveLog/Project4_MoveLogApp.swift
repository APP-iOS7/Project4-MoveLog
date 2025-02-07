//
//  Project4_MoveLogApp.swift
//  Project4-MoveLog
//
//  Created by 강보현 on 2/4/25.
//

import SwiftUI
import SwiftData

@main
struct Project4_MoveLogApp: App {
    @UIApplicationDelegateAdaptor(AppDelegate.self) var appDelegate
    // SwiftData를 사용하여 공유 모델 컨테이너 생성
    var sharedModelContainer: ModelContainer = {
        let schema = Schema([
            Workout.self,
            UserProfile.self,
            Meal.self,
            MyWorkout.self,
        ])
        // SwiftData 컨테이너 설정 (`isStoredInMemoryOnly: false` → 실제 저장됨)
        let modelConfiguration = ModelConfiguration(schema: schema, isStoredInMemoryOnly: false)
        // SwiftData ModelContainer 생성 및 설정
        do {
            return try ModelContainer(for: schema, configurations: [modelConfiguration])
        } catch {
            fatalError("Could not create ModelContainer: \(error)")
        }
    }()
    // 앱의 UI 화면을 나타냄
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        // SwiftData 컨테이너 연결
        .modelContainer(sharedModelContainer)
    }
}
// 앱의 Delegate (알림 관련 설정 및 초기화)
class AppDelegate: NSObject, UIApplicationDelegate {
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey : Any]? = nil) -> Bool {
        // NotificationManager 초기화
        _ = NotificationManager.shared
        return true
    }
}

