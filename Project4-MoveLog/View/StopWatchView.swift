//
//  StopWatchView.swift
//  Project4-MoveLog
//
//  Created by 강보현 on 2/5/25.
//

import SwiftUI

struct StopwatchView: View {
    @State private var isRunning = false
    @State private var timer: Timer?
    @State private var elapsedTime: TimeInterval = 0
    @Binding var stoppedTime: TimeInterval // 정지된 시간 저장


    var body: some View {
        VStack {
            Text(formatTime(elapsedTime))
                .font(.system(size: 50, weight: .bold, design: .monospaced))
                .padding()

            HStack {
                Button(action: startStopwatch) {
                    Text(isRunning ? "정지" : "시작")
                        .frame(width: 100, height: 50)
                        .background(isRunning ? Color.red : Color("mainColor"))
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }

                Button(action: resetStopwatch) {
                    Text("리셋")
                        .frame(width: 100, height: 50)
                        .background(Color.gray.opacity(0.6))
                        .foregroundColor(.white)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                }
            }
        }
    }

    private func startStopwatch() {
        if isRunning {
            timer?.invalidate()
            stoppedTime = elapsedTime
        } else {
            timer = Timer.scheduledTimer(withTimeInterval: 0.01, repeats: true) { _ in
                elapsedTime += 0.01
            }
        }
        isRunning.toggle()
    }

    private func resetStopwatch() {
        timer?.invalidate()
        elapsedTime = 0
        stoppedTime = 0
        isRunning = false
    }

    private func formatTime(_ time: TimeInterval) -> String {
        let minutes = Int(time) / 60
        let seconds = Int(time) % 60
        let milliseconds = Int((time * 100).truncatingRemainder(dividingBy: 100))
        return String(format: "%02d:%02d:%02d", minutes, seconds, milliseconds)
    }
}
