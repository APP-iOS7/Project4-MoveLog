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
    
    @State private var profile: UserProfile?
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
        .onAppear {
            loadProfile()
        }
        .onChange(of: gender) { calculateBMR() }
        .onChange(of: age) { calculateBMR() }
        .onChange(of: height) { calculateBMR() }
        .onChange(of: weight) { calculateBMR() }
    }
    
    private func loadProfile() {
        Task {
            do {
                let fetchDescriptor = FetchDescriptor<UserProfile>()
                let profiles = try modelContext.fetch(fetchDescriptor)
                
                if let existingProfile = profiles.first {
                    self.profile = existingProfile
                    self.gender = existingProfile.gender
                    self.age = String(existingProfile.age)
                    self.height = String(existingProfile.height)
                    self.weight = String(existingProfile.weight)
                    calculateBMR()
                } else {
                    print("저장된 프로필 없음")
                }
            } catch {
                print("프로필 불러오기 실패: \(error)")
            }
        }
    }
    
    private func calculateBMR() {
        guard let ageInt = Int(age), let heightDouble = Double(height), let weightDouble = Double(weight) else {
            bmr = 0.0
            return
        }
        bmr = UserProfile.calculateBMR(gender: gender, age: ageInt, height: heightDouble, weight: weightDouble)
    }
    ///  userProfile 저장
    private func saveUserProfile() {
        guard let ageInt = Int(age),
              let heightDouble = Double(height),
              let weightDouble = Double(weight)
        else { return }
        if let existingProfile = profile {
            // 기존 프로필 업데이트
            existingProfile.gender = gender
            existingProfile.age = ageInt
            existingProfile.height = heightDouble
            existingProfile.weight = weightDouble
            existingProfile.bmr = bmr
        } else {
            // 새로운 프로필 생성 후 저장
            let newUser = UserProfile(gender: gender, age: ageInt, height: heightDouble, weight: weightDouble)
            modelContext.insert(newUser)
            self.profile = newUser
        }
        do {
            try modelContext.save()
            print("프로필 저장 완료")
        } catch {
            print("프로필 저장 실패: \(error)")
        }
        dismiss()
    }
}


#Preview {
    UserProfileView()
}
