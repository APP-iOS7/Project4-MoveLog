import Foundation
import UserNotifications

class AlarmManager {
    static let shared = AlarmManager()
    
    // 🔹 알람 설정 함수
    func setAlarm(hour: Int, minute: Int, period: String, days: Set<String>, sound: String) {
        // 알림 권한 요청
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, error in
            if granted {
                print("✅ 알림 권한이 허용되었습니다.")
                self.scheduleAlarm(hour: hour, minute: minute, period: period, days: days, sound: sound)
            } else {
                print("❌ 알림 권한이 거부되었습니다.")
            }
        }
    }
    
    // 🔹 실제 알람을 예약하는 함수
    private func scheduleAlarm(hour: Int, minute: Int, period: String, days: Set<String>, sound: String) {
        let center = UNUserNotificationCenter.current()
        center.removeAllPendingNotificationRequests() // ✅ 기존 테스트 알림 삭제
        
        for day in days {
            let weekday = ["월": 2, "화": 3, "수": 4, "목": 5, "금": 6, "토": 7, "일": 1][day] ?? 2
            
            var dateComponents = DateComponents()
            dateComponents.weekday = weekday
            dateComponents.hour = period == "PM" ? hour + 12 : hour
            dateComponents.minute = minute
            
            let trigger = UNCalendarNotificationTrigger(dateMatching: dateComponents, repeats: true)
            let content = UNMutableNotificationContent()
            content.title = "운동할 시간입니다!"
            content.body = "운동을 해보세요! 건강을 위해 움직여 볼까요?"
            content.sound = sound == "벨소리" ? .default : .none
            
            let request = UNNotificationRequest(identifier: UUID().uuidString, content: content, trigger: trigger)
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
    
    // 🔹 모든 알람 삭제 함수 (테스트 초기화용)
    func removeAllAlarms() {
        UNUserNotificationCenter.current().removeAllPendingNotificationRequests()
        print("🗑 모든 알람이 삭제되었습니다.")
    }
}
