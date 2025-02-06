// ExerciseAlarmView.swift
//  Project4-MoveLog
//
//  Created by 변영찬 on 2/6/25.
//

import SwiftUI

struct ExerciseAlarmView: View {
    let exercise: ExerciseModel
    @State private var timeRemaining: Int = 60 // 기본 60초 타이머
    @State private var timerRunning = false
    @State private var timer: Timer?

    var body: some View {
        VStack(spacing: 20) {
            Text("운동 시간!")
                .font(.largeTitle)
                .bold()
            
            Text(exercise.name)
                .font(.title)
                .bold()
                .padding()

            Text(exercise.description)
                .font(.body)
                .multilineTextAlignment(.center)
                .padding()
            
            Text("\(timeRemaining) 초")
                .font(.system(size: 40, weight: .bold))
                .padding()
            
            HStack {
                Button(timerRunning ? "일시정지" : "시작") {
                    if timerRunning {
                        stopTimer()
                    } else {
                        startTimer()
                    }
                }
                .foregroundStyle(Color.white)
                .background(Color("mainColor"))
                .buttonStyle(.bordered)
                .clipShape(RoundedRectangle(cornerRadius: 10))
                
                Button("초기화") {
                    resetTimer()
                }
                .foregroundStyle(Color.black.opacity(0.5))
                .buttonStyle(.bordered)
                .clipShape(RoundedRectangle(cornerRadius: 10))

            }
        }
        .padding()
        .onDisappear {
            stopTimer()
        }
    }

    private func startTimer() {
        timerRunning = true
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            if timeRemaining > 0 {
                timeRemaining -= 1
            } else {
                stopTimer()
            }
        }
    }

    private func stopTimer() {
        timerRunning = false
        timer?.invalidate()
    }

    private func resetTimer() {
        stopTimer()
        timeRemaining = 60
    }
}

// 운동 데이터 모델
struct ExerciseModel: Identifiable, Codable, Equatable {
    let id: UUID
    let name: String
    let description: String
    
    static func randomExercise() -> ExerciseModel {
           return sampleExercises.randomElement() ?? sampleExercises[0]
       }
    
}

// 샘플 운동 데이터 (10가지)
let sampleExercises: [ExerciseModel] = [
    ExerciseModel(id: UUID(), name: "스쿼트", description: "엉덩이를 뒤로 빼면서 앉았다 일어나세요."),
    ExerciseModel(id: UUID(), name: "푸쉬업", description: "팔을 어깨너비로 벌리고 내려갔다 올라오세요."),
    ExerciseModel(id: UUID(), name: "런지", description: "한쪽 다리를 앞으로 내밀고 내려갔다 올라오세요."),
    ExerciseModel(id: UUID(), name: "버피 테스트", description: "점프 후 팔굽혀펴기를 연속으로 수행하세요."),
    ExerciseModel(id: UUID(), name: "플랭크", description: "팔꿈치를 대고 몸을 곧게 유지하세요."),
    ExerciseModel(id: UUID(), name: "마운틴 클라이머", description: "팔굽혀펴기 자세에서 무릎을 번갈아 가며 당기세요."),
    ExerciseModel(id: UUID(), name: "점핑 잭", description: "팔을 벌리며 점프하고 다시 모으세요."),
    ExerciseModel(id: UUID(), name: "사이드 플랭크", description: "몸을 옆으로 돌리고 팔꿈치로 버티세요."),
    ExerciseModel(id: UUID(), name: "니 업", description: "무릎을 높이 올리면서 제자리 뛰기 하세요."),
    ExerciseModel(id: UUID(), name: "레그 레이즈", description: "누워서 다리를 들어 올렸다 내리세요.")
]

