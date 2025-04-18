// страница перед опросом

import SwiftUI

struct OnboardingView: View {
    var onFinish: () -> Void
    @State private var navigateToSurvey = false

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.black, Color(red: 0.1, green: 0.1, blue: 0.2)]),
                           startPoint: .top,
                           endPoint: .bottom)
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Spacer()

                Image("soulmate_birds")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 180, height: 180)
                    .padding(.top, 50)

                Text("Welcome to\nSoulMate - AI Chat")
                    .foregroundColor(.white)
                    .font(.title.bold())
                    .multilineTextAlignment(.center)
                    .padding()

                Text("Find your best friend or partner\nand share what you want")
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding()

                Spacer()

                Text("Let's create our own AI friend! To do this, answer a few questions.")
                    .foregroundColor(.gray)
                    .multilineTextAlignment(.center)
                    .padding(.horizontal)

                Button(action: {
                    onFinish()
                }) {
                    HStack {
                        Text("Let's Start!")
                            .font(.headline.bold())
                        Image(systemName: "arrow.right")
                    }
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.red)
                    .cornerRadius(15)
                    .padding(.horizontal, 20)
                }
                .padding(.bottom, 40)
            }
        }
    }
}
