//
//  AddWorkoutView.swift
//  Project4-MoveLog
//
//  Created by SG on 2/4/25.
//

import SwiftUI
import SwiftData


struct WorkOutEditView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    let workOut: Workout
    
    @State private var name: String = ""
    @State private var duration: Int = 0
    @State private var caloriesBurned: Int = 0
    
    @State private var hoursString = "00"
    @State private var minutesString = "00"
    @State private var secondsString = "00"
    
    
    
    
    init(workOut: Workout) {
        self.workOut = workOut
        _name = State(initialValue: workOut.name)
        _duration = State(initialValue: workOut.duration)
        _caloriesBurned = State(initialValue: workOut.caloriesBurned)
        
        let hours = workOut.duration / 3600
                let minutes = (workOut.duration % 3600) / 60
                let seconds = workOut.duration % 60
        
        _hoursString = State(initialValue: String(format: "%02d", hours))
               _minutesString = State(initialValue: String(format: "%02d", minutes))
               _secondsString = State(initialValue: String(format: "%02d", seconds))
    }
    
    
    var body: some View {
        
        
        TextField("운동 이름", text: $name)
            .font(.title2)
            .fontWeight(.bold)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(Color.gray.opacity(0.4))
            .cornerRadius(8)
        
        HStack {
            
            
            TextField("HH", text: Binding(
                get: { hoursString },
                set: { newValue in
                    let filteredValue = newValue.filter { $0.isNumber }
                    let limitedValue = String(filteredValue.prefix(2))
                    
                    if let intValue = Int(limitedValue), intValue <= 24 {
                        hoursString = limitedValue
                    } else {
                        hoursString = "23"
                    }
                    updateDuration()
                }
            ))
            .fontWeight(.bold)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(Color.gray.opacity(0.4))
            .cornerRadius(8)
            ValueBox(unit: ":")
            
            TextField("mm", text: Binding(
                get: { minutesString },
                set: { newValue in
                    let filteredValue = newValue.filter { $0.isNumber }
                    let limitedValue = String(filteredValue.prefix(2))
                    
                    if let intValue = Int(limitedValue), intValue <= 60 {
                        minutesString = limitedValue
                    } else {
                        minutesString = "59"
                    }
                    updateDuration()
                }
            ))
            .fontWeight(.bold)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(Color.gray.opacity(0.4))
            .cornerRadius(8)
            
            ValueBox(unit: ":")
            TextField("ss", text: Binding(
                get: { secondsString },
                set: { newValue in
                    let filteredValue = newValue.filter { $0.isNumber }
                    let limitedValue = String(filteredValue.prefix(2))
                    
                    if let intValue = Int(limitedValue), intValue <= 60 {
                        secondsString = limitedValue
                    } else {
                        secondsString = "59"
                    }
                    updateDuration()
                }
            ))
            .fontWeight(.bold)
            .padding(.horizontal, 8)
            .padding(.vertical, 4)
            .background(Color.gray.opacity(0.4))
            .cornerRadius(8)
        }
        
        HStack {
            Text("소모 칼로리")
                .font(.caption)
                .foregroundColor(.gray)
            TextField("소모 칼로리", value: $caloriesBurned, formatter: NumberFormatter())
                .fontWeight(.bold)
                .padding(.horizontal, 8)
                .padding(.vertical, 4)
                .background(Color.gray.opacity(0.4))
                .cornerRadius(8)
            ValueBox(unit: "kcal")
        }
        
        .padding()
        .background(Color.gray.opacity(0.3))
        .cornerRadius(12)
        .padding(.horizontal, 20)
        
        Spacer()
            .navigationTitle("운동 작성")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("저장") {
                        workOut.name = name
                        workOut.duration = duration
                        workOut.caloriesBurned = caloriesBurned
                        
                        modelContext.insert(workOut)
                         try? modelContext.save()
                        dismiss()
                    }
                }
        
            }
    }
    private func updateDuration() {
          let hours = Int(hoursString) ?? 0
          let minutes = Int(minutesString) ?? 0
          let seconds = Int(secondsString) ?? 0
          
          duration = (hours * 3600) + (minutes * 60) + seconds
      }
    
}


struct ValueBox: View {
    var unit: String
    
    var body: some View {
        HStack {
            Text(unit)
                .font(.caption)
                .foregroundColor(.gray)
        }
    }
}


#Preview {
    WorkOutEditView(workOut: Workout(name: "Running", duration: 10, caloriesBurned: 100, date: Date()))
}
