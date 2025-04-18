// основная страница с созаднным партнером

import SwiftUI

struct PartnerView: View {
    var onStartChat: () -> Void

    @AppStorage("userName") var userName: String = "AI Partner"
    @AppStorage("imageName") var imageName: String = "appearance1"
    @AppStorage("hobbies") var hobbies: String = "Traveling, Yoga, Dancing"

    @State private var showPaywall = false

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.black, Color(red: 0.1, green: 0.1, blue: 0.2)]),
                           startPoint: .top,
                           endPoint: .bottom)
                .ignoresSafeArea()

            VStack(spacing: 0) {
                // 🔹 Header
                HStack {
                    Text("Partner")
                        .font(.title2.bold())
                        .foregroundColor(.white)

                    Spacer()

                    Button(action: {
                        showPaywall = true
                    }) {
                        Text("UNLIMITED")
                            .font(.caption.bold())
                            .foregroundColor(.black)
                            .padding(.horizontal, 12)
                            .padding(.vertical, 6)
                            .background(Color.yellow)
                            .cornerRadius(8)
                    }
                }
                .padding(.horizontal)
                .padding(.top, 50)

                ScrollView {
                    VStack(spacing: 20) {
                        // 🔹 Avatar
                        Image(imageName)
                            .resizable()
                            .scaledToFill()
                            .frame(width: 120, height: 120)
                            .clipShape(Circle())
                            .overlay(Circle().stroke(Color.white, lineWidth: 2))
                            .shadow(radius: 10)

                        // 🔹 Name & Age
                        Text(userName)
                            .font(.title3.bold())
                            .foregroundColor(.white)

                        Text("25 years old")
                            .foregroundColor(.gray)

                        // 🔹 Hobbies
                        Text(formattedHobbies())
                            .font(.caption)
                            .foregroundColor(.white)
                            .multilineTextAlignment(.center)
                            .padding(.horizontal)

                        Divider()
                            .background(Color.gray.opacity(0.3))
                            .padding(.horizontal)

                        // 🔹 Photos
                        HStack {
                            Text("Photos")
                                .foregroundColor(.white)
                                .font(.headline)

                            Spacer()

                            Text("SEE ALL")
                                .foregroundColor(.gray)
                                .font(.caption.bold())
                        }
                        .padding(.horizontal)

                        ScrollView(.horizontal, showsIndicators: false) {
                            HStack(spacing: 12) {
                                ForEach(0..<3) { _ in
                                    Image(imageName)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 100, height: 140)
                                        .cornerRadius(12)
                                        .shadow(radius: 5)
                                }
                            }
                            .padding(.horizontal)
                        }

                        Spacer()
                            .frame(height: 20)
                    }
                }

                // 🔹 Bottom Button
                VStack(spacing: 0) {
                    Divider().background(Color.gray.opacity(0.3))

                    Button(action: {
                        onStartChat()
                    }) {
                        Text("Start a conversation")
                            .font(.headline.bold())
                            .foregroundColor(.white)
                            .padding()
                            .frame(maxWidth: .infinity)
                            .background(Color.red)
                            .cornerRadius(15)
                            .padding(.horizontal, 20)
                            .padding(.vertical, 10)
                    }
                }
                .background(Color(red: 15/255, green: 20/255, blue: 45/255).ignoresSafeArea())
            }
        }
        .fullScreenCover(isPresented: $showPaywall) {
            PaywallView()
        }
    }

    private func formattedHobbies() -> String {
        let emojiMap: [String: String] = [
            "Traveling": "🌍", "Yoga": "🧘‍♀️", "Dancing": "💃",
            "Movies": "🎬", "Animals": "🐶", "Photography": "📸"
        ]
        let hobbyList = hobbies.split(separator: ",").map { $0.trimmingCharacters(in: .whitespaces) }
        return hobbyList.map { "\(emojiMap[$0] ?? "⭐️") \($0)" }.joined(separator: "  ")
    }
}
