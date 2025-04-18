// страница с настройками

import SwiftUI

struct ProfileView: View {
    @State private var showPaywall = false

    var body: some View {
        ZStack {
            // Фон
            LinearGradient(
                gradient: Gradient(colors: [Color.black, Color(red: 0.1, green: 0.1, blue: 0.2)]),
                startPoint: .top,
                endPoint: .bottom
            )
            .ignoresSafeArea()

            VStack(spacing: 16) {
                HStack {
                    Text("Profile")
                        .font(.title2.bold())
                        .foregroundColor(.white)

                    Spacer()

                    Button(action: {
                        print("Tapped UNLIMITED")
                        showPaywall = true
                    }) {
                        Text("UNLIMITED")
                            .foregroundColor(.black)
                            .font(.caption.bold())
                            .padding(.vertical, 6)
                            .padding(.horizontal, 12)
                            .background(Color.yellow)
                            .cornerRadius(8)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 50)

                VStack(spacing: 20) {
                    ProfileRow(title: "Terms of Use")
                    ProfileRow(title: "Privacy Policy")
                    ProfileRow(title: "Support")
                }
                .padding(.horizontal)
                .padding(.top, 20)

                Spacer()
            }
        }
        .fullScreenCover(isPresented: $showPaywall) {
            PaywallView()
        }
    }
}

struct ProfileRow: View {
    var title: String

    var body: some View {
        HStack {
            Text(title)
                .foregroundColor(.white)
                .font(.body)

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding(.vertical, 8)
        .overlay(
            Divider()
                .background(Color.gray.opacity(0.3)),
            alignment: .bottom
        )
    }
}
