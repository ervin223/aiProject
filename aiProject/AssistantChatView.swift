import SwiftUI

struct AssistantChatView: View {
    var assistant: Assistant
    var onBack: () -> Void

    @State private var messages: [String] = [
        "Name:\nThe site rybaxet will help a designer, layout designer...",
        "You:\nThe site rybaxet will help a designer, layout designer..."
    ]
    @State private var newMessage: String = ""

    var body: some View {
        ZStack {
            Color(red: 15/255, green: 15/255, blue: 20/255)
                .ignoresSafeArea()

            VStack(spacing: 0) {

                // 🔵 Header без отступов
                HStack {
                    Button(action: { onBack() }) {
                        Image(systemName: "chevron.left")
                            .foregroundColor(.white)
                            .padding(8)
                            .background(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.white.opacity(0.6), lineWidth: 1)
                            )
                    }

                    Spacer()

                    Text(assistant.title)
                        .font(.headline)
                        .foregroundColor(.white)

                    Spacer()

                    Rectangle()
                        .frame(width: 30)
                        .opacity(0)
                }
                .padding(.horizontal)
                .frame(height: 50)
                .background(Color(red: 15/255, green: 15/255, blue: 25/255))

                // ✅ ScrollView без safe area без top offset
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(messages, id: \.self) { message in
                            if message.starts(with: "You:") {
                                HStack {
                                    Spacer()
                                    Text(message.replacingOccurrences(of: "You:\n", with: ""))
                                        .padding()
                                        .background(Color.gray.opacity(0.6))
                                        .cornerRadius(16)
                                        .foregroundColor(.white)
                                        .frame(maxWidth: 300, alignment: .trailing)
                                }
                            } else {
                                HStack {
                                    Text(message.replacingOccurrences(of: "Name:\n", with: ""))
                                        .padding()
                                        .background(Color.gray.opacity(0.3))
                                        .cornerRadius(16)
                                        .foregroundColor(.white)
                                        .frame(maxWidth: 300, alignment: .leading)
                                    Spacer()
                                }
                            }
                        }
                    }
                    .padding(.horizontal)
                    .padding(.top, 8) // ✅ Минимальный правильный отступ
                }

                // Input зона
                VStack(spacing: 8) {
                    HStack {
                        TextField("Type your message", text: $newMessage)
                            .padding()
                            .foregroundColor(.white)
                            .background(Color.clear)

                        Button(action: { newMessage = "" }) {
                            Image(systemName: "xmark")
                                .foregroundColor(.white.opacity(0.7))
                        }

                        Text("\(newMessage.count)/500")
                            .foregroundColor(.gray)
                            .font(.caption)

                        Button(action: {
                            if !newMessage.isEmpty && newMessage.count <= 500 {
                                messages.append("You:\n" + newMessage)
                                newMessage = ""
                            }
                        }) {
                            Image(systemName: "paperplane.fill")
                                .foregroundColor(.red)
                        }
                    }
                    .padding()
                    .background(
                        LinearGradient(
                            gradient: Gradient(colors: [Color(red: 20/255, green: 20/255, blue: 30/255), Color.black]),
                            startPoint: .top,
                            endPoint: .bottom
                        )
                    )
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .padding(.horizontal, 8)
                    .padding(.bottom, 8)
                }
            }
        }
    }
}
