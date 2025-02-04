//
//  ContentView.swift
//  Project4-MoveLog
//
//  Created by 강보현 on 2/4/25.
//

import SwiftUI
import SwiftData

struct ContentView: View {
    @Environment(\.modelContext) private var modelContext
    @Query private var items: [Item]
    
    var body: some View {
        ScrollView {
            VStack(spacing: 20){
                HStack {
                    Text("무브로그")
                        .font(.system(size: 30, weight: .bold, design: .default))
                    Spacer()
                    Button(action: {
                        // 화면 이동
                    }, label: {
                        Image(systemName: "bell")
                    })
                }
                RoundedRectangle(cornerRadius: 10).fill(Color.gray).frame(width: .infinity, height: 300)
                VStack {
                    // 운동 기록
                        
                }
                VStack {
                    // 식단 기록
                        
                }
                Button(action: {
                    // 화면 이동
                }, label: {
                    Text("Start")
                })
            }
            .padding(16)
        }
    }
}


#Preview {
    ContentView()
        .modelContainer(for: Item.self, inMemory: true)
}
