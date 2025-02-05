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
                        HStack {
                            Text("\(workout.type.rawValue)")
                            Spacer()
                            Text(workout.name)
                                .font(.title3)
                                .frame(width: 220, alignment: .leading)
                        }
                        .padding(.vertical, 5)
//                        .swipeActions(edge: .leading, allowsFullSwipe: false) {
//                            Button("Edit") {
//                                selectedWorkout = workout  //  선택한 운동 저장
//                            }
//                            .tint(.blue)
//                        }
                        .contentShape(Rectangle())
                        .onTapGesture {
                            selectedWorkout = workout
                        }

                    }
                    
                    .onDelete(perform: deleteItems)
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
            //  Edit 버튼을 눌렀을 때 WorkOutEditView로 이동
            .navigationDestination(isPresented: Binding(
                get: { selectedWorkout != nil },
                set: { if !$0 { selectedWorkout = nil } }
            )) {
                if let workout = selectedWorkout {
                    WorkoutEditView(workout: workout)
                }
            }
        }
    }
    
    /// 운동 삭제 함수
    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            for index in offsets {
                modelContext.delete(workouts[index])
            }
        }
    }
}

#Preview {
    WorkoutListView()
        .modelContainer(PreviewContainer.shared.container)
}
