// страница с основным чатом 

import SwiftUI

struct ChatView: View {
    var userName: String
    var userImage: String
    var onBack: () -> Void

    @State private var messages: [ChatMessage] = []
    @State private var newMessage: String = ""
    @State private var isTyping = false
    @State private var shownImages: Set<String> = []
    @State private var showPaywall = false

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack(spacing: 0) {
                // Header
                HStack {
                    Button(action: { onBack() }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .padding()
                    }

                    Spacer()

                    Text("Chat")
                        .font(.headline)
                        .foregroundColor(.white)

                    Spacer()

                    Button(action: {
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
                .frame(height: 50)
                .background(Color(red: 15/255, green: 20/255, blue: 45/255))

                // Chat messages
                ScrollView {
                    VStack(alignment: .leading, spacing: 16) {
                        ForEach(messages.indices, id: \.self) { index in
                            let message = messages[index]
                            messageView(message)
                        }

                        if isTyping {
                            HStack {
                                Text("...")
                                    .italic()
                                    .foregroundColor(.gray)
                                Spacer()
                            }
                        }
                    }
                    .padding()
                }

                // Input
                VStack(spacing: 8) {
                    HStack(spacing: 10) {
                        Button {
                            messages.append(.image(userImage))
                        } label: {
                            Label("Ask for a photo", systemImage: "camera.fill")
                        }
                        .buttonStyle(ChatButtonStyle())

                        Button {
                            newMessage = "What do you like to do in your free time?"
                        } label: {
                            Label("Generate question", systemImage: "lightbulb.fill")
                        }
                        .buttonStyle(ChatButtonStyle())
                    }

                    HStack {
                        TextField("Enter your message", text: $newMessage)
                            .padding()
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(10)
                            .foregroundColor(.white)

                        Button {
                            if !newMessage.isEmpty {
                                messages.append(.text("You: \(newMessage)"))
                                isTyping = true
                                let prompt = newMessage
                                newMessage = ""

                                Task {
                                    if let response = await OllamaService.shared.sendMessage(prompt) {
                                        await MainActor.run {
                                            messages.append(.text("\(userName): \(response)"))
                                            isTyping = false
                                        }
                                    }
                                }
                            }
                        } label: {
                            Image(systemName: "paperplane.fill")
                                .foregroundColor(.red)
                                .padding()
                        }
                    }
                    .padding(.horizontal)
                }
                .padding(.bottom, 8)
                .background(Color(red: 15/255, green: 20/255, blue: 45/255))
            }
        }
        .sheet(isPresented: $showPaywall) {
            PaywallView()
        }
        .onAppear {
            if messages.isEmpty {
                messages.append(.text("AI: Привет! Я помогу тебе узнать человека поближе 👋"))
                messages.append(.image(userImage))
            }
        }
    }

    @ViewBuilder
    func messageView(_ message: ChatMessage) -> some View {
        switch message {
        case .text(let content):
            if content.starts(with: "You:") {
                HStack {
                    Spacer()
                    Text(content)
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.gray.opacity(0.6))
                        .cornerRadius(12)
                }
            } else {
                HStack {
                    Text(content.replacingOccurrences(of: "AI:", with: "\(userName):"))
                        .foregroundColor(.white)
                        .padding()
                        .background(Color.gray.opacity(0.3))
                        .cornerRadius(12)
                    Spacer()
                }
            }

        case .image(let imageName):
            HStack {
                VStack(alignment: .leading, spacing: 4) {
                    Text("\(userName):")
                        .font(.caption)
                        .foregroundColor(.white.opacity(0.7))

                    ZStack {
                        Image(imageName)
                            .resizable()
                            .aspectRatio(3/4, contentMode: .fit)
                            .frame(width: 220)
                            .cornerRadius(16)
                            .overlay {
                                if !shownImages.contains(imageName) {
                                    Color.black.opacity(0.3).cornerRadius(16)
                                    BlurView(style: .systemUltraThinMaterialDark).cornerRadius(16)
                                }
                            }
                            .clipped()

                        if !shownImages.contains(imageName) {
                            Button("Show") {
                                withAnimation {
                                    _ = shownImages.insert(imageName)
                                }
                            }
                            .font(.caption.bold())
                            .padding(.vertical, 8)
                            .padding(.horizontal, 24)
                            .background(Color.red)
                            .foregroundColor(.white)
                            .cornerRadius(20)
                        }
                    }
                }
                Spacer()
            }
            .padding(.horizontal)
        }
    }
}

// MARK: - ChatMessage enum

enum ChatMessage: Hashable {
    case text(String)
    case image(String)
}

// MARK: - Blur View

struct BlurView: UIViewRepresentable {
    var style: UIBlurEffect.Style = .systemMaterial

    func makeUIView(context: Context) -> UIVisualEffectView {
        UIVisualEffectView(effect: UIBlurEffect(style: style))
    }

    func updateUIView(_ uiView: UIVisualEffectView, context: Context) {}
}

// MARK: - Button Style

struct ChatButtonStyle: ButtonStyle {
    func makeBody(configuration: Configuration) -> some View {
        configuration.label
            .font(.caption)
            .padding(.vertical, 8)
            .padding(.horizontal, 12)
            .background(Color.gray.opacity(0.3))
            .foregroundColor(.white)
            .cornerRadius(10)
            .scaleEffect(configuration.isPressed ? 0.95 : 1.0)
    }
}
