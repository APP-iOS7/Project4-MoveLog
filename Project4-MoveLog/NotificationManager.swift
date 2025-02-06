//
//  NotificationManager.swift
//  Project4-MoveLog
//
//  Created by 강보현 on 2/6/25.
//
import SwiftUI
import UserNotifications

class NotificationManager: NSObject, UNUserNotificationCenterDelegate {
    static let shared = NotificationManager()
    
    override private init() {
        super.init()
        // delegate 설정
        UNUserNotificationCenter.current().delegate = self
    }
    
    func requestAuthorization() async {
        do {
            let granted = try await UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .badge, .sound])
            if granted {
                print("알림 권한이 승인되었습니다")
                await MainActor.run {
                    NotificationCenter.default.post(name: NSNotification.Name("OpenAlarmView"), object: nil)
                }
            }
        } catch {
            print("알림 권한 오류: \(error.localizedDescription)")
        }
    }
    
    // 앱이 foreground 상태일 때 알림이 온 경우
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                              willPresent notification: UNNotification,
                              withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        // 알림 배너, 사운드 표시
        completionHandler([.banner, .sound])
    }
    
    // 사용자가 알림을 탭했을 때
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                              didReceive response: UNNotificationResponse,
                              withCompletionHandler completionHandler: @escaping () -> Void) {
        print("alarm touched")
        let identifier = response.notification.request.identifier
        let userInfo = response.notification.request.content.userInfo
        print("📩 userInfo: \(userInfo)")

        Task { @MainActor in
            NotificationCenter.default.post(
                name: NSNotification.Name("OpenAlarmView"),
                object: nil,
                userInfo: userInfo
            )
        }
        
        completionHandler()
    }
}
