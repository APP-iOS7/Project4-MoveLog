//
//  EditWorkoutView.swift
//  Project4-MoveLog
//
//  Created by SG on 2/4/25.
//

import SwiftUI




struct WorkOutListView: View {
    @Environment(\.dismiss) private var dismiss
    @State private var searchText = "" // 검색어 상태
    @State private var workout = [
        WorkOut(name: "스쿼트", category: "하체", kcal: 100),
        WorkOut(name: "팔굽혀펴기", category: "상체", kcal: 100),
        WorkOut(name: "달리기", category: "유산소", kcal: 100),
        WorkOut(name: "등산", category: "유산소", kcal: 100)
    ] // 더미 데이터
    
    var filteredWorkOut: [WorkOut] {
        if searchText.isEmpty {
            return workout
        } else {
            return workout.filter { $0.name.contains(searchText) }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                // 검색창
                TextField("검색 창", text: $searchText)
                    .padding()
                    .background(Color.gray.opacity(0.3))
                    .cornerRadius(10)
                    .padding(.horizontal)
                
                // 리스트 뷰
                List {
                    ForEach(filteredWorkOut) { exercise in
                        HStack {
                            Text(exercise.name)
                                .font(.title3)
                            Spacer()
                            Text(exercise.category)
                                .font(.caption)
                                .foregroundColor(.black)
                                .padding(8)
                                .background(Color.green.opacity(0.6))
                                .cornerRadius(10)
                        }
                        .padding(.vertical, 5)
                        .swipeActions(edge: .leading, allowsFullSwipe: false) {
                            Button("Edit") {
                                print("\(exercise.name) 수정 버튼 클릭")
                            }
                            .tint(.blue)
                        }
                        .swipeActions(edge: .trailing) {
                            Button("Delete", role: .destructive) {
                                deleteExercise(exercise)
                            }
                        }
                    }
                }
                .background(Color.gray.opacity(0.3))
                .cornerRadius(20)
                .padding()
            }
            // 하단 버튼
            HStack {
                Button(action: {
                    //TODO: 구현 필요
                }) {
                    Text("운동 추가")
                        .font(.system(size: 16, weight: .bold))
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.green.opacity(0.6))
                        .foregroundColor(.black)
                        .cornerRadius(12)
                }
                .frame(width: 120)
            }
            
            
            .padding(.horizontal, 20)
            .navigationTitle("운동 목록")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("추가") {
                        print("추가버튼 눌림")
                        dismiss()
                    }
                    
                }
            }
        }
 
    }
    
    // 운동 삭제 함수
    private func deleteExercise(_ exercise: WorkOut) {
        withAnimation {
            workout.removeAll { $0.id == exercise.id }
        }
    }
}


#Preview {
    WorkOutListView()
}
