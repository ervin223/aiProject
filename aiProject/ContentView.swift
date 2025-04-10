import SwiftUI

struct ContentView: View {
    @AppStorage("isRegistered") private var isRegistered = false

    @State private var showLaunch = true
    @State private var showOnboarding = false
    @State private var showSurvey = false
    @State private var showChat = false

    var body: some View {
        ZStack {
            if showLaunch {
                LaunchView {
                    withAnimation {
                        showLaunch = false
                        if !isRegistered {
                            showOnboarding = true
                        }
                    }
                }
            } else if showOnboarding {
                OnboardingView {
                    showOnboarding = false
                    showSurvey = true
                }
            } else if showSurvey {
                SurveyView(surveyCompleted: {
                    isRegistered = true
                    showSurvey = false
                    showChat = true
                })
            } else if showChat {
                ChatView(userName: "AI Partner", userImage: "appearance1", onBack: {
                    showChat = false
                })
            } else {
                MainTabView(onStartChat: {
                    showChat = true
                })
            }
        }
    }
}
