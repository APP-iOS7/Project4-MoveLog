import Foundation
import UserNotifications

class AlarmManager {
    static let shared = AlarmManager()
    
    /// ** 알람 설정 함수**
    /// - 사용자가 설정한 시간, 요일, 사운드 정보를 받아서 알람을 예약
    /// - 내부적으로 `scheduleAlarm` 호출하여 실제 알람 등록 수행
    func setAlarm(hour: Int, minute: Int, period: String, days: Set<String>, sound: String) {
        self.scheduleAlarm(hour: hour, minute: minute, period: period, days: days, sound: sound)
        
    }
    
    /// **실제 알람을 예약하는 함수**
    /// - 사용자가 설정한 요일마다 개별적으로 알람을 등록
    /// - `UNCalendarNotificationTrigger`를 사용하여 특정 요일, 시간에 알람 실행
    private func scheduleAlarm(hour: Int, minute: Int, period: String, days: Set<String>, sound: String) {
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests() // 기존 테스트 알림 삭제
        
        for day in days {
            let weekday = ["월": 2, "화": 3, "수": 4, "목": 5, "금": 6, "토": 7, "일": 1][day] ?? 2
            
            var dateComponents = DateComponents()
            dateComponents.weekday = weekday
            dateComponents.hour = period == "PM" ? hour + 12 : hour
            dateComponents.minute = minute
            // 특정 요일, 시간에 알람 트리거 설정
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            
            // 알람에 표시될 내용 설정
            let content = UNMutableNotificationContent()
            content.title = "운동할 시간입니다!"
            content.body = "운동을 해보세요! 건강을 위해 움직여 볼까요?"
            content.sound = sound == "벨소리" ? .default : .none
            content.userInfo = ["isAlarmTouched": "userInfoTest"]
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
            // 알람 추가
            center.add(request) { error in
                if let error = error {
                    print("❌ 알람 설정 실패: \(error.localizedDescription)")
                } else {
                    print("✅ 알람이 예약되었습니다!")
                    print("⏰ 시간: \(period) \(hour):\(String(format: "%02d", minute)) | 요일: \(day) | 사운드: \(sound)")
                }
            }
        }
    }
    
    /// - 모든 예약된 알람을 제거
    func removeAllAlarms() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        print("🗑 모든 알람이 삭제되었습니다.")
    }
}
