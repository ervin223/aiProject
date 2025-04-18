// отдельная часть кода с табами на главной странице

import SwiftUI

struct MainTabView: View {
    var onStartChat: () -> Void
    var userName: String
    var imageName: String
    var hobbies: String

    var body: some View {
        TabView {
            PartnerView(onStartChat: onStartChat, userName: userName, imageName: imageName, hobbies: hobbies)
                .tabItem {
                    Image(systemName: "heart.fill")
                    Text("Partner")
                }

            AssistantView()
                .tabItem {
                    Image(systemName: "person.fill.questionmark")
                    Text("Assistants")
                }

            ArticlesView()
                .tabItem {
                    Image(systemName: "doc.text.image")
                    Text("Articles")
                }

            ProfileView()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Profile")
                }
        }
        .accentColor(.red)
    }
}
