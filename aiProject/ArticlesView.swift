// страница а артиклями 

import SwiftUI

struct Article: Identifiable {
    let id = UUID()
    let title: String
    let description: String
}

struct ArticlesView: View {
    @State private var selectedArticle: Article? = nil
    @State private var showPaywall = false

    var body: some View {
        ZStack {
            LinearGradient(gradient: Gradient(colors: [Color.black, Color(red: 0.1, green: 0.1, blue: 0.2)]),
                           startPoint: .top,
                           endPoint: .bottom)
                .ignoresSafeArea()

            VStack(spacing: 16) {
                // Header
                HStack {
                    Text("Articles")
                        .font(.title2.bold())
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
                .padding(.top, 50)

                ScrollView {
                    VStack(spacing: 12) {
                        ArticleCard(image: "article1", title: "Psychologist", description: "Discuss what's on your mind and work through emotional challenges.") {
                            selectedArticle = Article(title: "Psychologist", description: "Discuss what's on your mind and work through emotional challenges.")
                        }
                        ArticleCard(image: "article2", title: "Therapist", description: "Explore your feelings and mental health in a safe, confidential space.") {
                            selectedArticle = Article(title: "Therapist", description: "Explore your feelings and mental health in a safe, confidential space.")
                        }
                        ArticleCard(image: "article3", title: "Life Coach", description: "Get guidance on achieving personal goals and improving your life direction.") {
                            selectedArticle = Article(title: "Life Coach", description: "Get guidance on achieving personal goals and improving your life direction.")
                        }
                    }
                    .padding(.horizontal)
                }

                Spacer()
            }
            .fullScreenCover(item: $selectedArticle) { article in
                ArticleDetailView(title: article.title, description: article.description)
            }
            .fullScreenCover(isPresented: $showPaywall) {
                PaywallView()
            }
        }
    }
}

struct ArticleCard: View {
    var image: String
    var title: String
    var description: String
    var onTap: () -> Void

    var body: some View {
        Button(action: { onTap() }) {
            ZStack(alignment: .bottomLeading) {
                Image(image)
                    .resizable()
                    .aspectRatio(16/9, contentMode: .fill)
                    .frame(maxWidth: .infinity)
                    .frame(height: 150)
                    .cornerRadius(15)
                    .clipped()

                LinearGradient(gradient: Gradient(colors: [Color.black.opacity(0.5), Color.clear]),
                               startPoint: .bottom,
                               endPoint: .top)
                    .cornerRadius(15)

                HStack {
                    VStack(alignment: .leading, spacing: 4) {
                        Text(title)
                            .foregroundColor(.white)
                            .font(.headline.bold())
                            .multilineTextAlignment(.leading)

                        Text(description)
                            .foregroundColor(.white)
                            .font(.caption)
                            .fixedSize(horizontal: false, vertical: true)
                            .multilineTextAlignment(.leading)
                            .frame(maxWidth: .infinity, alignment: .leading)
                    }
                    Spacer()
                    Image(systemName: "chevron.right.circle.fill")
                        .foregroundColor(.white)
                        .font(.title2)
                }
                .padding()
            }
            .frame(height: 150)
            .background(Color.clear)
            .cornerRadius(15)
        }
    }
}

struct ArticleDetailView: View {
    var title: String
    var description: String
    @Environment(\.dismiss) private var dismiss

    var body: some View {
        ZStack {
            Color(red: 0.05, green: 0.05, blue: 0.1).ignoresSafeArea()
            VStack(alignment: .leading, spacing: 16) {
                HStack {
                    Button(action: { dismiss() }) {
                        Image(systemName: "chevron.left")
                            .padding(8)
                            .background(Color.gray.opacity(0.2))
                            .clipShape(RoundedRectangle(cornerRadius: 6))
                    }
                    Spacer()
                    Text("Article")
                        .font(.headline)
                        .foregroundColor(.white)
                    Spacer()
                    Spacer()
                }
                .padding()

                Text(title)
                    .font(.headline.bold())
                    .foregroundColor(.white)
                    .padding(.horizontal)

                Text(description)
                    .foregroundColor(.white)
                    .padding(.horizontal)

                Spacer()
            }
        }
    }
}
