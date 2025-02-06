import SwiftUI

struct AlarmTriggerView: View {
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        VStack {
            Text("운동할 시간입니다!")
                .font(.largeTitle)
                .bold()
                .padding()

            Button("운동 시작하기") {
                presentationMode.wrappedValue.dismiss()
            }
            .buttonStyle(.borderedProminent)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
        .background(Color.black.opacity(0.8))
        .edgesIgnoringSafeArea(.all)
    }
}

