//
//  ContentView.swift
//  Project4-MoveLog
//
//  Created by 강보현 on 2/4/25.
//
import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @State private var showAlarmView = false
    @State private var selectedDate: Date = Date()
    @State private var isFromNotification = false // 앱 실행 시 알람 클릭 여부 추적
    @State private var notificationExercise: ExerciseModel?
    
    var body: some View {
        NavigationStack {
            VStack {
                ScrollView {
                    DatePicker("Select Date", selection: $selectedDate, displayedComponents: [.date])
                        .datePickerStyle(.graphical)
                        .background(Color.gray.opacity(0.1))
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .tint(Color("darkColor"))
                        .padding()
                    
                    Spacer(minLength: 30)
                    
                    HStack {
                        Text("칼로리 소비량")
                            .font(.title2)
                            .fontWeight(.bold)
                        Spacer()
                    }
                }
            }
            .navigationTitle("무브로그")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    NavigationLink(destination: AlarmSettingsView()) {
                        Image(systemName: "bell")
                    }
                }
            }
            .onAppear {
                Task {
                    await NotificationManager.shared.requestAuthorization()
                }
                NotificationCenter.default.addObserver(forName: NSNotification.Name("OpenAlarmView"), object: nil, queue: .main) { notification in
                    print("📢 OpenAlarmView 알림 수신!")
                    if let userInfo = notification.userInfo {
                        self.showAlarmView = true
                        print("userInfo : \(userInfo)")
                    }
                    else {
                        print("⚠️ userInfo에 데이터 없음")
                    }
                    self.isFromNotification = true
                }
            }
            .sheet(isPresented: $showAlarmView) {
                ExerciseAlarmView(exercise: ExerciseModel.randomExercise())
            }
        }
    }
}

extension Date {
    func startOfDay() -> Date {
        return Calendar.current.startOfDay(for: self)
    }
}

#Preview {
    ContentView()
        .modelContainer(PreviewContainer.shared.container)
}
