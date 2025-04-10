import SwiftUI

struct Assistant: Identifiable {
    let id = UUID()
    let title: String
    let subtitle: String
    let image: String
}

struct AssistantView: View {
    @State private var selectedAssistant: Assistant? = nil

    let assistants = [
        Assistant(title: "Psychologist", subtitle: "Discuss what's on your mind and work through emotional challenges.", image: "assistant1"),
        Assistant(title: "Therapist", subtitle: "Explore your feelings and mental health in a safe, confidential space.", image: "assistant2"),
        Assistant(title: "Life Coach", subtitle: "Get guidance on achieving personal goals and improving your life direction.", image: "assistant3"),
        Assistant(title: "Mental Health", subtitle: "Address mental health issues and work on long-term well-being.", image: "assistant4"),
        Assistant(title: "Relationship Coach", subtitle: "Improve communication and resolve conflicts in your relationships.", image: "assistant5")
    ]

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.black, Color(red: 0.1, green: 0.1, blue: 0.2)]),
                           startPoint: .top,
                           endPoint: .bottom)
                .ignoresSafeArea()

            VStack(spacing: 16) {
                // Header
                HStack {
                    Text("Assistants")
                        .font(.title2.bold())
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
                .padding(.top, 50)

                // List of assistants
                ScrollView {
                    VStack(spacing: 12) {
                        ForEach(assistants) { assistant in
                            Button {
                                selectedAssistant = assistant
                            } label: {
                                AssistantCard(
                                    image: assistant.image,
                                    title: assistant.title,
                                    subtitle: assistant.subtitle
                                )
                            }
                        }
                    }
                    .padding(.horizontal)
                }

                Spacer()
            }
        }
        .fullScreenCover(item: $selectedAssistant) { assistant in
            AssistantChatView(assistant: assistant, onBack: { selectedAssistant = nil })
        }
    }
}

struct AssistantCard: View {
    var image: String
    var title: String
    var subtitle: String

    var body: some View {
        HStack(spacing: 12) {
            Image(image)
                .resizable()
                .scaledToFill()
                .frame(width: 50, height: 50)
                .clipShape(Circle())

            VStack(alignment: .leading, spacing: 4) {
                Text(title)
                    .foregroundColor(.white)
                    .font(.headline.bold())

                Text(subtitle)
                    .foregroundColor(.gray)
                    .font(.caption)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Spacer()

            Image(systemName: "chevron.right")
                .foregroundColor(.gray)
        }
        .padding()
        .background(Color.gray.opacity(0.2))
        .cornerRadius(15)
    }
}
