import SwiftUI

struct AINameSelectionView: View {
    var currentQuestion: Int
    var totalQuestions: Int
    @Binding var aiName: String
    @Binding var termsAccepted: Bool
    var nextAction: () -> Void

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 15) {
                Text("Welcome to\nSoulMate - AI Chat")
                    .foregroundColor(.white)
                    .font(.title.bold())
                    .multilineTextAlignment(.center)
                    .padding(.top, 40)

                HStack(spacing: 5) {
                    ForEach(1...totalQuestions, id: \.self) { index in
                        Image(systemName: index <= currentQuestion ? "heart.fill" : "heart")
                            .foregroundColor(index <= currentQuestion ? .red : .gray)
                    }
                }
                .padding(.top, 5)

                Text("Questions \(currentQuestion)/\(totalQuestions)")
                    .foregroundColor(.gray)
                    .font(.subheadline)
                    .padding(.bottom, 10)

                Text("What to call the AI partner?")
                    .foregroundColor(.white)
                    .font(.title2.bold())
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)

                TextField("Enter AI name", text: $aiName)
                    .padding()
                    .background(Color.white.opacity(0.2))
                    .cornerRadius(8)
                    .padding(.horizontal, 20)

                Toggle(isOn: $termsAccepted) {
                    Text("By joining the chat, I accept the terms")
                        .foregroundColor(.white)
                }
                .padding(.horizontal, 20)

                Button(action: nextAction) {
                    Text("Continue")
                        .font(.headline.bold())
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background((aiName.count > 0 && termsAccepted) ? Color.red : Color.gray)
                        .cornerRadius(15)
                        .padding(.horizontal, 20)
                }
                .disabled(aiName.isEmpty || !termsAccepted)
                .padding(.top, 20)
            }
        }
    }
}
