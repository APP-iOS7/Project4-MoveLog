//
//  EditWorkoutView.swift
//  Project4-MoveLog
//
//  Created by SG on 2/4/25.
//

import SwiftUI
import SwiftData

struct WorkoutListView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @Query private var workouts: [Workout]  // 전체 운동 목록을 불러옴
    @Query private var myWorkout: [MyWorkout]
    @State private var searchText = "" // 검색어 상태
    @State private var selectedWorkout: Workout? //  선택된 운동 저장
    
    var filteredWorkouts: [Workout] {
        if searchText.isEmpty {
            return workouts
        } else {
            return workouts.filter { $0.name.contains(searchText) }
        }
    }
    
    var body: some View {
        NavigationStack {
            VStack {
                // 검색창
                HStack {
                    Image(systemName: "magnifyingglass")
                    TextField("검색 창", text: $searchText)
                }
                .padding()
                .background(Color.gray.opacity(0.1))
                .cornerRadius(10)
                .padding()
                // 운동 리스트
                List {
                    ForEach(filteredWorkouts) { workout in
                        NavigationLink(destination: WorkoutEditView(workout: workout)) {
                            HStack {
                                Text("\(workout.type.rawValue)")
                                Spacer()
                                Text(workout.name)
                                    .font(.title3)
                                    .frame(width: 220, alignment: .leading)
                            }
                            .padding(.vertical, 5)
                        }
                    }
                    .onDelete(perform: deleteItems)
                }
            }
            .listStyle(.plain)
            .cornerRadius(10)
            .padding(.horizontal)
        }
        .navigationTitle("운동 목록")
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                NavigationLink(destination: WorkoutEditView(workout: Workout(name: "새 운동", type: .cardio))) {
                    Text("추가")
                }
            }
        }
        //  Edit 버튼을 눌렀을 때 WorkoutEditView로 이동
        //            .navigationDestination(isPresented: Binding(
        //                get: { selectedWorkout != nil },
        //                set: { if !$0 { selectedWorkout = nil } }
        //            )) {
        //                if let workout = selectedWorkout {
        //                    WorkoutEditView(workout: workout)
        //                }
        //            }
        // 이렇게하면 HomeView위로 쌓임
    }
    
    /// 운동 삭제 함수
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
                for index in offsets {
                    let workoutToDelete = workouts[index] // ✅ 삭제할 Workout 찾기
                    
                    // ✅ `MyWorkout`에서도 해당 Workout을 사용하는 데이터 찾기
                    let relatedWorkouts = myWorkout.filter { $0.workout == workoutToDelete }
                    
                    // ✅ 관련된 MyWorkout도 삭제
                    for myWorkout in relatedWorkouts {
                        modelContext.delete(myWorkout)
                    }
                    
                    // ✅ 원본 Workout 삭제
                    modelContext.delete(workoutToDelete)
                }
                
                // ✅ 변경 사항 저장
                do {
                    try modelContext.save()
                } catch {
                    print("❌ 삭제 후 저장 실패: \(error)")
                }
            }
    }
}

#Preview {
    WorkoutListView()
        .modelContainer(PreviewContainer.shared.container)
}
