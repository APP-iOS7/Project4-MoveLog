//
//  WorkoutAddView.swift
//  Project4-MoveLog
//
//  Created by SG on 2/5/25.
//

import SwiftUI
import SwiftData


struct WorkoutAddView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State private var name: String = ""
    @State private var caloriesBurned: Int = 0
    @State private var selectedType: WorkoutType = .cardio
    
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
                        let workout = Workout(name: name, duration: 0, caloriesBurned: caloriesBurned, date: Date(), type: selectedType)
                        modelContext.insert(workout)
//                        try? modelContext.save()
                        dismiss()
                        
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

    
}
#Preview {
    WorkoutAddView()
        .modelContainer(PreviewContainer.shared.container)
}
