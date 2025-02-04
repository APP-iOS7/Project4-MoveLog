//
//  AddWorkoutView.swift
//  Project4-MoveLog
//
//  Created by SG on 2/4/25.
//

import SwiftUI



struct AddWorkoutView: View {
    
    @State private var workOut: String = ""
    @State private var workOutKcal: Int = 0
    
    // 무산소 운동은 세트, 무게, 횟수를 입력받음
    @State private var workOutSet: Int = 0
    @State private var workOutWeight: Int = 0
    @State private var workOutReps: Int = 0
    
    // 유산소 운동은 무게 대신 시간을 입력받기 위해
    @State var isCardio: Bool = false
    @State private var hoursString = "00"
    @State private var minutesString = "30"
    @State private var secondsString = "00"
    @State private var timeRemaining: Int = 0
    @State private var seletedCategory: Int = 0
    let category = ["하체", "상체", "유산소"]
    
    var body: some View {
        VStack {
            Spacer()
            
            // 운동 정보 카드
            VStack(spacing: 16) {
                
                HStack {
                    Text("카테고리")
                        .font(.caption)
                        .foregroundColor(.gray)
                    
                    ForEach(0..<category.count, id: \.self) { index in
                        Button(action: {
                            seletedCategory = index
                            isCardio = (index == 2) // "유산소" 버튼이 선택되었을 때
                        }) {
                            Text(category[index])
                                .padding()
                                .background(seletedCategory == index ? Color.blue : Color.gray)
                                .foregroundColor(.white)
                                .cornerRadius(10)
                        }
                    }
                    
                    
                }
                
                TextField("운동 이름", text: $workOut)
                    .font(.title2)
                    .fontWeight(.bold)
                    .padding(.horizontal, 8)
                    .padding(.vertical, 4)
                    .background(Color.gray.opacity(0.4))
                    .cornerRadius(8)
                
                HStack {
                    
                    if isCardio == false {
                        TextField("세트", value: $workOutSet, formatter: NumberFormatter())
                            .fontWeight(.bold)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.gray.opacity(0.4))
                            .cornerRadius(8)
                        ValueBox(unit: "set")
                        
                        TextField("무게", value: $workOutWeight, formatter: NumberFormatter())
                            .fontWeight(.bold)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.gray.opacity(0.4))
                            .cornerRadius(8)
                        ValueBox(unit: "kg")
                        
                        TextField("횟수", value: $workOutReps, formatter: NumberFormatter())
                            .fontWeight(.bold)
                            .padding(.horizontal, 8)
                            .padding(.vertical, 4)
                            .background(Color.gray.opacity(0.4))
                            .cornerRadius(8)
                        ValueBox(unit: "reps")
                    }
                    /// 유산소의 경우
                    else {
                        TextField("HH", text: Binding(
                            get: { hoursString },
                            set: { newValue in
                                hoursString = String(newValue.filter { $0.isNumber }.prefix(2))
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
                                minutesString = String(newValue.filter { $0.isNumber }.prefix(2))
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
                                secondsString = String(newValue.filter { $0.isNumber }.prefix(2))
                            }
                        ))
                        .fontWeight(.bold)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.gray.opacity(0.4))
                        .cornerRadius(8)
                    }
                }
                
                HStack {
                    Text("소모 칼로리")
                        .font(.caption)
                        .foregroundColor(.gray)
                    TextField("소모 칼로리", value: $workOutKcal, formatter: NumberFormatter())
                        .fontWeight(.bold)
                        .padding(.horizontal, 8)
                        .padding(.vertical, 4)
                        .background(Color.gray.opacity(0.4))
                        .cornerRadius(8)
                    ValueBox(unit: "kcal")
                }
                
                
            }
            .padding()
            .background(Color.gray.opacity(0.3))
            .cornerRadius(12)
            .padding(.horizontal, 20)
            
            Spacer()
            
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
                Spacer()
                Button(action: {
                    //TODO: 구현 필요
                }) {
                    Text("운동 리스트")
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
        }
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
    AddWorkoutView()
}
