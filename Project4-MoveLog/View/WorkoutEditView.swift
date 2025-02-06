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
    @State private var selectedType: WorkoutType
    @State private var name: String = ""
    
    init(workout: Workout) {
        self.workout = workout
        _name = State(initialValue: workout.name)
        _selectedType = State(initialValue: workout.type)
    }

    var body: some View {

        NavigationStack {
            Spacer()
            List {
                TextField("운동 이름", text: $name)
                    .padding(.vertical , 5)
                    .font(.title2)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                Picker("운동 유형", selection: $selectedType) {
                    ForEach(WorkoutType.allCases, id: \.self) { type in
                        Text(type.rawValue).tag(type)
                    }
                }
                .pickerStyle(.menu)
                .tint(Color("textColor"))
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
                        modelContext.insert(workout)
                        try? modelContext.save()
                        dismiss()
                    }
                    
                    
                }
            }
    }
}

#Preview {
    WorkoutEditView(workout: Workout(name: "Running", type: .cardio))
}
