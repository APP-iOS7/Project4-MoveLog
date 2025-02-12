//
//  MealAddView.swift
//  Project4-MoveLog
//
//  Created by SG on 2/5/25.
//

import SwiftUI
import SwiftData

struct MealAddView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var name: String = ""
    @State private var calories: Int = 0
    
    var selectedDate: Date

    var body: some View {
        NavigationStack {
            VStack {
                HStack {
                    Text("식단 작성")
                        .font(.title)
                        .bold()
                    Spacer()
                }
                .padding(.vertical, 30)
                // 음식 이름 입력 필드
                HStack {
                    Text("식단")
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                    Spacer()
                }
                TextField("음식 이름", text: $name)
                    .font(.title2)
                    .frame(maxWidth: .infinity, maxHeight: 40)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 5)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                HStack {
                    Text("칼로리")
                        .font(.system(size: 20))
                        .foregroundColor(.black)
                    Spacer()
                }
                .padding(EdgeInsets(top: 20, leading: 0, bottom: 0, trailing: 0))
                // 칼로리 입력 필드
                HStack {
                    TextField("칼로리", value: $calories, formatter: NumberFormatter())
                        .fontWeight(.bold)
                        .multilineTextAlignment(.trailing)
                        .padding(.vertical, 4)
                        .padding(.horizontal, 10)
                        .background(Color.gray.opacity(0.1))
                        .cornerRadius(10)
                    Spacer()
                    ValueBox(unit: "kcal")
                }
                Spacer()
            }
            .padding()
        }
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button("저장") {
                    let meals = Meal(name: name, calories: calories, date: selectedDate)
                    modelContext.insert(meals)
                    dismiss()
                }
                .foregroundStyle(Color.black)
            }
            
        }
    }
}


#Preview {
    MealAddView(selectedDate: Date())
        .modelContainer(PreviewContainer.shared.container)
}

