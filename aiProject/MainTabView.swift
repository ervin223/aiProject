import SwiftUI

struct MainTabView: View {
    var onStartChat: () -> Void

    var body: some View {
        TabView {
            PartnerView(onStartChat: onStartChat)
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

            ProfileView() // временно, потом заменим на ProfileView()
                .tabItem {
                    Image(systemName: "person.crop.circle")
                    Text("Profile")
                }
        }
        .accentColor(.red)
    }
}
