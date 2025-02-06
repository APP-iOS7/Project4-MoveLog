//
//  ValueBox.swift
//  Project4-MoveLog
//
//  Created by 강보현 on 2/6/25.
//

import SwiftUI

struct ValueBox: View {
    var unit: String
    
    var body: some View {
        HStack {
            Text(unit)
                .font(.caption)
                .foregroundColor(.gray.opacity(0.1))
        }
    }
}
