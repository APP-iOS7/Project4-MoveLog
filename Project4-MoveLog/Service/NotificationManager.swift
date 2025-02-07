//
//  NotificationManager.swift
//  Project4-MoveLog
//
//  Created by 강보현 on 2/6/25.
//
import SwiftUI
import UserNotifications

/// ** NotificationManager - 알림 관리 클래스**
/// - 앱에서 알림 권한 요청, 알림 수신 및 처리 담당
/// - `UNUserNotificationCenterDelegate`를 채택하여 알림 이벤트 핸들링
class NotificationManager: NSObject, UNUserNotificationCenterDelegate {
    static let shared = NotificationManager()
    
    override private init() {
        super.init()
        // delegate 설정
        UNUserNotificationCenter.current().delegate = self
    }
    
    /// ** 알림 권한 요청 함수**
    /// - 사용자가 앱 실행 시, 알림을 받을 수 있도록 권한 요청
    /// - 승인되면 `OpenAlarmView` 이벤트를 `NotificationCenter`에 전달
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
    
    /// 앱이 Foreground (실행 중) 상태일 때 알림을 수신
    /// 기본적으로 iOS에서는 알림이 뜨지 않지만, 이 코드가 있으면 배너와 소리가 나오게 됨
    /// .banner → 화면 상단에 알림 표시 / .sound → 알림이 도착하면 소리 재생
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                willPresent notification: UNNotification,
                                withCompletionHandler completionHandler: @escaping (UNNotificationPresentationOptions) -> Void) {
        completionHandler([.banner, .sound])
    }
    
    /// 앱이 백그라운드에 있거나 종료된 상태에서 알림을 눌렀을 때 실행
    /// - 알림의 식별자 및 `userInfo` 데이터 여부를 확인하여 처리 가능
    /// NotificationCenter를 사용하여 다른 뷰에서 이벤트 감지 가능
    /// - `OpenAlarmView` 이벤트를 `NotificationCenter`에 전달하여 화면 전환 트리거
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        print("Alarm touched")
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
