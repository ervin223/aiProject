import SwiftUI

struct AppearanceQuestionView: View {
    @Binding var selectedAppearance: String?
    var currentQuestion: Int
    var totalQuestions: Int
    var nextAction: () -> Void
    
    let availableImages = ["appearance1", "appearance2", "woman1", "woman2"] // Имена картинок в `Assets`
    
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
                
                Text("Select the appearance of the AI partner")
                    .foregroundColor(.white)
                    .font(.title2.bold())
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 10)
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(availableImages, id: \ .self) { imageName in
                            ZStack {
                                Image(imageName)
                                    .resizable()
                                    .scaledToFill()
                                    .frame(width: 120, height: 160)
                                    .cornerRadius(12)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 12)
                                            .stroke(selectedAppearance == imageName ? Color.red : Color.clear, lineWidth: 4)
                                    )
                                
                                if selectedAppearance == imageName {
                                    Image(systemName: "checkmark.circle.fill")
                                        .foregroundColor(.red)
                                        .background(Circle().foregroundColor(.white))
                                        .offset(x: 40, y: -60)
                                }
                            }
                            .onTapGesture {
                                selectedAppearance = imageName
                            }
                        }
                    }
                    .padding(.horizontal)
                }
                
                Button(action: {
                    if selectedAppearance != nil {
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
                    .background(selectedAppearance == nil ? Color.gray : Color.red)
                    .cornerRadius(15)
                    .padding(.horizontal, 20)
                }
                .disabled(selectedAppearance == nil)
                .padding(.top, 20)
            }
            .padding(.vertical, 30)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
