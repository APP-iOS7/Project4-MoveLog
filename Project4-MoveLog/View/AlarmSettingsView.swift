import SwiftUI

struct AlarmSettingsView: View {
    @AppStorage("alarmHour") private var alarmHour: Int = 7
    @AppStorage("alarmMinute") private var alarmMinute: Int = 0
    @AppStorage("alarmPeriod") private var alarmPeriod: String = "AM"
    @AppStorage("alarmSound") private var alarmSound: String = "벨소리"
    
    @AppStorage("savedAlarms") private var savedAlarmsData: String = "[]" // 🔹 JSON 문자열로 저장

    let days = ["월", "화", "수", "목", "금", "토", "일"]
    let sounds = ["벨소리", "진동"]
    
    @State private var alarmDays: Set<String> = []
    @State private var savedAlarms: [AlarmModel] = []

    var body: some View {
        NavigationStack {
            VStack(spacing: 20) {
                Text("랜덤운동 시간 설정")
                    .font(.title)
                    .bold()
                
                // 시간 설정
                HStack {
                    Picker("오전/오후", selection: $alarmPeriod) {
                        Text("AM").tag("AM")
                        Text("PM").tag("PM")
                    }
                    .pickerStyle(SegmentedPickerStyle())

                    Picker("시간", selection: $alarmHour) {
                        ForEach(1...12, id: \.self) { Text("\($0)").tag($0) }
                    }
                    .tint(Color.black)

                    Text(":")
                        .foregroundStyle(Color.black)
                    
                    Picker("분", selection: $alarmMinute) {
                        ForEach(0...59, id: \.self) { Text(String(format: "%02d", $0)).tag($0) }
                    }
                    .tint(Color.black)
                }
                .frame(width: 300)

                // 요일 선택 (드롭다운)
                Menu {
                    ForEach(days, id: \.self) { day in
                        Button(action: { toggleDaySelection(day) }) {
                            Label(day, systemImage: alarmDays.contains(day) ? "checkmark.circle.fill" : "circle")
                        }
                    }
                } label: {
                    Text(alarmDays.isEmpty ? "반복할 요일 선택" : alarmDays.sorted(by: daySort).joined(separator: ", "))
                        .foregroundColor(Color.black)
                }

                // 사운드 선택
                Picker("사운드 설정", selection: $alarmSound) {
                    ForEach(sounds, id: \.self) {
                        Text($0).tag($0)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())

                // 알람 저장 버튼
                Button("알람 저장") {
                    saveAlarm()
                }
                .buttonStyle(.borderedProminent)
                .tint(Color("mainColor"))
                

                // 🔹 저장된 알람 목록 표시
                List {
                    ForEach(savedAlarms) { alarm in
                        HStack {
                            Text("\(alarm.period) \(alarm.hour):\(String(format: "%02d", alarm.minute))")
                            Spacer()
                            Text(alarm.days.joined(separator: ", "))
                                .foregroundColor(.gray)
                        }
                    }
                    .onDelete(perform: deleteAlarm) // 🔹 스와이프로 개별 삭제
                }
                .frame(height: 200)

                // 🔹 알람 전체 삭제 버튼
                Button("모든 알람 삭제") {
                    removeAllAlarms()
                }
                .buttonStyle(.bordered)
                .foregroundColor(.red)

                Spacer()
            }
            .padding()
            .navigationTitle("알람 설정")
            .tint(.black)
            .onAppear {
                loadAlarms()
            }
        }
    }

    // ✅ 요일 선택 함수
    private func toggleDaySelection(_ day: String) {
        if alarmDays.contains(day) {
            alarmDays.remove(day)
        } else {
            alarmDays.insert(day)
        }
    }

    // ✅ 요일 정렬 함수
    private let dayOrder: [String] = ["월", "화", "수", "목", "금", "토", "일"]
    private func daySort(_ a: String, _ b: String) -> Bool {
        return dayOrder.firstIndex(of: a) ?? 7 < dayOrder.firstIndex(of: b) ?? 7
    }

    // ✅ 알람 저장 함수
    private func saveAlarm() {
        let sortedDays = alarmDays.sorted(by: daySort) // ✅ 요일 정렬

        let newAlarm = AlarmModel(
            hour: alarmHour,
            minute: alarmMinute,
            period: alarmPeriod,
            days: sortedDays,
            sound: alarmSound
        )

        savedAlarms.append(newAlarm)
        saveAlarmsToStorage()

        // 실제 알람 스케줄링 실행
        AlarmManager.shared.setAlarm(hour: alarmHour, minute: alarmMinute, period: alarmPeriod, days: Set(sortedDays), sound: alarmSound)
    }

    // ✅ 알람 목록 로드 함수
    private func loadAlarms() {
        if let data = savedAlarmsData.data(using: .utf8),
           let alarms = try? JSONDecoder().decode([AlarmModel].self, from: data) {
            self.savedAlarms = alarms.map { alarm in
                let sortedDays = alarm.days.sorted(by: daySort) // ✅ 요일 정렬 적용
                return AlarmModel(id: alarm.id, hour: alarm.hour, minute: alarm.minute, period: alarm.period, days: sortedDays, sound: alarm.sound)
            }
        }
    }

    // ✅ 알람 저장 함수 (UserDefaults 사용)
    private func saveAlarmsToStorage() {
        if let data = try? JSONEncoder().encode(savedAlarms),
           let jsonString = String(data: data, encoding: .utf8) {
            savedAlarmsData = jsonString
        }
    }

    // ✅ 개별 알람 삭제 함수
    private func deleteAlarm(at offsets: IndexSet) {
        savedAlarms.remove(atOffsets: offsets)
        saveAlarmsToStorage()
    }

    // ✅ 전체 알람 삭제 함수
    private func removeAllAlarms() {
        savedAlarms.removeAll()
        savedAlarmsData = "[]"
        AlarmManager.shared.removeAllAlarms()
    }
}

#Preview {
    AlarmSettingsView()
}
