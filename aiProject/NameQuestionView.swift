// опрос с именем

import SwiftUI

struct NameQuestionView: View {
    @Binding var userName: String
    var currentQuestion: Int
    var totalQuestions: Int
    var nextAction: () -> Void
    @State private var isTermsAccepted = false
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.black, Color(red: 0.1, green: 0.1, blue: 0.2)]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                Text("Welcome to\nSoulMate - AI Chat")
                    .font(.title2.bold())
                    .foregroundColor(.white)
                    .multilineTextAlignment(.center)
                    .padding(.top, 40)
                
                HStack(spacing: 5) {
                    ForEach(1...totalQuestions, id: \ .self) { index in
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
                    .padding(.bottom, 10)
                
                TextField("Enter the name of your AI partner", text: $userName)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(15)
                    .foregroundColor(.white)
                    .padding(.horizontal, 20)
                    .onChange(of: userName) {
                        if userName.count > 20 {
                            userName = String(userName.prefix(20))
                        }
                    }
                
                Toggle(isOn: $isTermsAccepted) {
                    Text("By joining the chat, I accept the app’s terms and confirm that I am over 18 years old.")
                        .foregroundColor(.gray)
                        .font(.caption)
                }
                .padding(.horizontal, 20)
                .padding(.top, 10)
                
                Button(action: {
                    if isTermsAccepted && !userName.isEmpty {
                        nextAction()
                    }
                }) {
                    HStack {
                        Text("Continue")
                            .font(.headline.bold())
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background((userName.isEmpty || !isTermsAccepted) ? Color.gray : Color.red)
                    .cornerRadius(15)
                    .padding(.horizontal, 20)
                }
                .disabled(userName.isEmpty || !isTermsAccepted)
                .padding(.top, 20)
            }
            .padding(.vertical, 30)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
