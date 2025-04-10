import SwiftUI

struct QuestionView: View {
    var title: String
    var options: [String]
    @Binding var selectedOption: String?
    var currentQuestion: Int
    var totalQuestions: Int
    var nextAction: () -> Void
    
    // Иконки и флаги для каждого варианта ответа
    let icons: [String: String] = [
        "Male": "person.fill",
        "Female": "person.fill.badge.plus",
        "Non-binary": "person.2.fill",
        "Other": "questionmark.circle.fill",
        "Heterosexual": "venus.mars",
        "Homosexual": "rainbow",
        "Bisexual": "flag.fill",
        "Asexual": "flag.fill",
        "Romantic": "heart.circle.fill",
        "Friendly": "hands.clap.fill",
        "Supportive": "hand.raised.fill",
        "Intellectual": "brain.head.profile",
        "Traveling": "airplane",
        "Movies": "film.fill",
        "Animals": "pawprint.fill",
        "Photography": "camera.fill",
        "Yoga": "figure.yoga",
        "Art & Drawing": "paintbrush.fill",
        "Dancing": "figure.dance",
        "Reading": "book.fill",
        "Cooking": "fork.knife"
    ]
    
    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.black, Color(red: 0.1, green: 0.1, blue: 0.2)]), startPoint: .top, endPoint: .bottom)
                .ignoresSafeArea()
            
            VStack(spacing: 20) {
                // Заголовок
                VStack(spacing: 8) {
                    Text("Welcome to\nSoulMate - AI Chat")
                        .foregroundColor(.white)
                        .font(.title.bold())
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
                }
                .padding(.bottom, 10)
                
                // Вопрос
                Text(title)
                    .foregroundColor(.white)
                    .font(.title2.bold())
                    .multilineTextAlignment(.center)
                    .padding(.horizontal, 20)
                    .padding(.bottom, 10)
                
                // Варианты ответов (исправленный стиль для 4,5,6 вопросов)
                VStack(spacing: 12) {
                    ForEach(options, id: \ .self) { option in
                        Button(action: {
                            selectedOption = option
                        }) {
                            HStack {
                                if let iconName = icons[option] {
                                    Image(systemName: iconName)
                                        .foregroundColor(.white)
                                        .padding(.leading, 15)
                                }
                                
                                Text(option)
                                    .foregroundColor(.white)
                                    .padding()
                                    .font(.headline)
                                
                                Spacer()
                                
                                Image(systemName: selectedOption == option ? "record.circle.fill" : "circle")
                                    .foregroundColor(.white)
                                    .padding(.trailing, 15)
                            }
                            .frame(maxWidth: .infinity, minHeight: 55)
                            .background(selectedOption == option ? Color.white.opacity(0.2) : Color.gray.opacity(0.15))
                            .cornerRadius(15)
                            .overlay(
                                RoundedRectangle(cornerRadius: 15)
                                    .stroke(selectedOption == option ? Color.white : Color.clear, lineWidth: 2)
                            )
                            .padding(.horizontal, 20)
                        }
                    }
                }
                .padding(.bottom, 20)
                
                // Кнопка "Continue" теперь стилизована единообразно
                Button(action: nextAction) {
                    HStack {
                        Text("Continue")
                            .font(.headline.bold())
                        Image(systemName: "chevron.right")
                    }
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(selectedOption == nil ? Color.gray : Color.red)
                    .cornerRadius(15)
                    .padding(.horizontal, 20)
                }
                .disabled(selectedOption == nil)
                .padding(.bottom, 30)
            }
            .padding(.vertical, 30)
            .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .top)
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}
