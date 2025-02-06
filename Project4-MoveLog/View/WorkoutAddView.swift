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
    @State private var selectedType: WorkoutType = .cardio
    
    var body: some View {
        NavigationStack {
            List {
                TextField("운동 이름", text: $name)
                    .padding(.vertical , 5)
                    .font(.title2)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                
                HStack {
                    Picker("운동 유형", selection: $selectedType) {
                        ForEach(WorkoutType.allCases, id: \.self) { type in
                            Text(type.rawValue).tag(type)
                        }
                    }
                    .pickerStyle(.menu)
                    .frame(width: 150, alignment: .leading)
                    .clipShape(RoundedRectangle(cornerRadius: 10))
                    .foregroundStyle(Color.black)
                    .tint(.primary)
                    
                }
            }
            .background(Color.gray.opacity(0.3))
            .cornerRadius(12)
            .padding(.horizontal, 20)
            
        }
        .navigationTitle("운동 작성")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("저장") {
                    let workout = Workout(name: name, type: selectedType)
                    modelContext.insert(workout)
                    dismiss()
                }
                .foregroundStyle(Color.black)
            }
        }
    }
}

#Preview {
    WorkoutAddView()
        .modelContainer(PreviewContainer.shared.container)
}
