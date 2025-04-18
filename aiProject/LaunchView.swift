// страница запуска

import SwiftUI

struct LaunchView: View {
    @State private var progress: Double = 0.0
    var onComplete: () -> Void  

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.black, Color(red: 0.1, green: 0.1, blue: 0.2)]),
                           startPoint: .top,
                           endPoint: .bottom)
                .ignoresSafeArea()

            VStack(spacing: 20) {
                Spacer()

                Image("soulmate_logo")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 150, height: 150)
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

                ProgressView(value: progress, total: 1.0)
                    .progressViewStyle(LinearProgressViewStyle(tint: .red))
                    .frame(width: 200)
                    .padding()

                Text("Loading...")
                    .foregroundColor(.white)
                    .padding(.bottom, 20)

                Spacer()
            }
        }
        .onAppear {
            withAnimation(.linear(duration: 3)) {
                progress = 1.0
            }
            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                onComplete()
            }
        }
    }
}
