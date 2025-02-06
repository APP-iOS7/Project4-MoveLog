//
//  UserProfileView.swift
//  Project4-MoveLog
//
//  Created by 강보현 on 2/5/25.
//

import SwiftUI
import SwiftData

struct UserProfileView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss
    
    @State private var gender: Gender = .male
    @State private var age: String = ""
    @State private var height: String = ""
    @State private var weight: String = ""
    @State private var bmr: Double = 0.0
    
    var body: some View {
        NavigationStack {
            Form {
                Section(header: Text("기본 정보").font(.headline)) {
                    Picker("성별", selection: $gender) {
                        ForEach(Gender.allCases, id: \.self) { gender in
                            Text(gender.rawValue).tag(gender)
                        }
                    }
                    .pickerStyle(.segmented)
                    
                    TextField("나이", text: $age)
                        .keyboardType(.numberPad)
                    
                    TextField("키 (cm)", text: $height)
                        .keyboardType(.decimalPad)
                    
                    TextField("몸무게 (kg)", text: $weight)
                        .keyboardType(.decimalPad)
                }
                .padding(8)
                
                Section(header: Text("기초대사량 (BMR)")) {
                    Text("\(bmr, specifier: "%.2f") kcal")
                        .font(.title2)
                        .bold()
                }
            }
            .navigationTitle("프로필 설정")
            .toolbar {
                ToolbarItem(placement: .navigationBarTrailing) {
                    Button("저장") {
                        saveUserProfile()
                    }
                    .foregroundStyle(Color.black)
                    .fontWeight(.semibold)
                }
            }
        }
        .onChange(of: gender) { calculateBMR() }
        .onChange(of: age) { calculateBMR() }
        .onChange(of: height) { calculateBMR() }
        .onChange(of: weight) { calculateBMR() }
    }
    
    private func calculateBMR() {
        guard let ageInt = Int(age), let heightDouble = Double(height), let weightDouble = Double(weight) else {
            bmr = 0.0
            return
        }
        
        bmr = UserProfile.calculateBMR(gender: gender, age: ageInt, height: heightDouble, weight: weightDouble)
    }
    
    private func saveUserProfile() {
        guard let ageInt = Int(age),
              let heightDouble = Double(height),
              let weightDouble = Double(weight) else { return }
        
        let newUser = UserProfile(gender: gender, age: ageInt, height: heightDouble, weight: weightDouble)
        print(newUser)
        modelContext.insert(newUser)
        do {
            try modelContext.save()
            print("UserProfile 저장 성공!")
            
            // 저장된 데이터 개수 확인
            let fetchDescriptor = FetchDescriptor<UserProfile>()
            let savedProfiles = try modelContext.fetch(fetchDescriptor)
            print("저장된 UserProfile 개수: \(savedProfiles.count)")
            print("저장된 데이터: \(savedProfiles)")
            
        } catch {
            print("UserProfile 저장 실패: \(error)")
        }
        
        dismiss()
    }
}


#Preview {
    UserProfileView()
}
