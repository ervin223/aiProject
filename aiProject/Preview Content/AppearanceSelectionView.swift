import SwiftUI

struct AppearanceSelectionView: View {
    @Binding var selectedAppearance: String?
    var currentQuestion: Int
    var totalQuestions: Int
    var nextAction: () -> Void
    
    let appearances = ["appearance1", "appearance2", "appearance3"] // Названия изображений

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
                
                ScrollView(.horizontal, showsIndicators: false) {
                    HStack(spacing: 15) {
                        ForEach(appearances, id: \.self) { appearance in
                            Button(action: {
                                selectedAppearance = appearance
                            }) {
                                Image(appearance)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 150, height: 200)
                                    .cornerRadius(10)
                                    .overlay(
                                        RoundedRectangle(cornerRadius: 10)
                                            .stroke(selectedAppearance == appearance ? Color.red : Color.clear, lineWidth: 2)
                                    )
                            }
                        }
                    }
                    .padding(.horizontal, 20)
                }
                
                Button(action: nextAction) {
                    Text("Continue")
                        .font(.headline.bold())
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
        }
    }
}
