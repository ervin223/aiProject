import SwiftUI

struct ChatView: View {
    var userName: String
    var userImage: String
    var onBack: () -> Void
    
    @State private var messages: [String] = [
        "Some message", "You: reply"
    ]
    @State private var newMessage: String = ""
    @State private var isBlurred = true

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea() // ✅ РАСТЯНЕТСЯ ПРАВИЛЬНО НА ВСЁ

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

                    Button(action: {}) {
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

                // Chat Messages
                ScrollView {
                    VStack(alignment: .leading, spacing: 10) {
                        ForEach(messages, id: \.self) { message in
                            if message.starts(with: "You:") {
                                HStack {
                                    Spacer()
                                    Text(message)
                                        .padding()
                                        .background(Color.gray.opacity(0.6))
                                        .cornerRadius(12)
                                }
                            } else {
                                HStack {
                                    Text(message)
                                        .padding()
                                        .background(Color.gray.opacity(0.3))
                                        .cornerRadius(12)
                                    Spacer()
                                }
                            }
                        }
                    }
                    .padding()
                }
                .frame(maxWidth: .infinity, maxHeight: .infinity) // ✅ ОБЯЗАТЕЛЬНО

                // Input Bar
                VStack(spacing: 8) {
                    HStack(spacing: 10) {
                        Button(action: {}) {
                            HStack {
                                Image(systemName: "camera.fill")
                                Text("Ask for a photo")
                            }
                            .font(.caption)
                            .foregroundColor(.white)
                            .padding(.vertical, 6)
                            .padding(.horizontal, 12)
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(8)
                        }

                        Button(action: {}) {
                            HStack {
                                Image(systemName: "lightbulb.fill")
                                Text("Generate question")
                            }
                            .font(.caption)
                            .foregroundColor(.white)
                            .padding(.vertical, 6)
                            .padding(.horizontal, 12)
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(8)
                        }
                    }

                    HStack {
                        TextField("Enter your message", text: $newMessage)
                            .padding()
                            .background(Color.gray.opacity(0.3))
                            .cornerRadius(10)
                            .foregroundColor(.white)

                        Button(action: {
                            if !newMessage.isEmpty {
                                messages.append("You: \(newMessage)")
                                newMessage = ""
                            }
                        }) {
                            Image(systemName: "paperplane.fill")
                                .foregroundColor(.red)
                                .padding()
                        }
                    }
                    .padding(.horizontal)
                }
                .background(Color(red: 15/255, green: 20/255, blue: 45/255))
                .padding(.bottom, 8)
            }
        }
    }
}
