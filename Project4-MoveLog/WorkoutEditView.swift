//
//  AddWorkoutView.swift
//  Project4-MoveLog
//
//  Created by SG on 2/4/25.
//

import SwiftUI
import SwiftData


struct WorkoutEditView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    let workout: Workout
    @State private var name: String = ""
    @State private var caloriesBurned: Int = 0
    @State private var selectedType: WorkoutType

    init(workout: Workout) {
        self.workout = workout
        _name = State(initialValue: workout.name)
  
        _caloriesBurned = State(initialValue: workout.caloriesBurned)
        _selectedType = State(initialValue: workout.type)
    }
    
    var body: some View {
        NavigationStack {
            Spacer()
            List {
                TextField("운동 이름", text: $name)
                    .padding(.vertical , 5)
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.gray.opacity(0.4))
                    .cornerRadius(8)
                
                HStack {
                    Picker("운동 유형", selection: $selectedType) {
                        ForEach(WorkoutType.allCases, id: \.self) { type in
                            Text(type.rawValue).tag(type)
                        }
                    }
                    .pickerStyle(.menu)
                    .frame(width: 150, alignment: .leading)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .foregroundStyle(Color.blue)
                    .tint(.primary)
                    
                }
                
                HStack {
                    Text("소모 칼로리")
                        .font(.caption)
                        .foregroundColor(.gray)
                    TextField("소모 칼로리", value: $caloriesBurned, formatter: NumberFormatter())
                        .fontWeight(.bold)
                        .multilineTextAlignment(.trailing)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.gray.opacity(0.4))
                        .cornerRadius(8)
                    ValueBox(unit: "kcal")
                }
            }
            .background(Color.gray.opacity(0.3))
            .cornerRadius(12)
            .padding(.horizontal, 20)
            
        }
            Spacer()
                .navigationTitle("운동 작성")
                .toolbar {
                    ToolbarItem(placement: .navigationBarTrailing) {
                        Button("저장") {
                            workout.name = name
                            workout.type = selectedType
                            workout.caloriesBurned = caloriesBurned
                            
                            modelContext.insert(workout)
                            try? modelContext.save()
                            dismiss()
                        }
                }
        }
    }
}

private struct ValueBox: View {
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
    WorkoutEditView(workout: Workout(name: "Running", duration: 10, caloriesBurned: 100, date: Date(), type: .cardio))
        .modelContainer(PreviewContainer.shared.container)
}
