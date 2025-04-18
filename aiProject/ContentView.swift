// адрессация страниц

import SwiftUI

struct ContentView: View {
    @AppStorage("isRegistered") private var isRegistered = false
    @AppStorage("userName") private var userName: String = ""
    @AppStorage("imageName") private var imageName: String = ""
    @AppStorage("hobbies") private var hobbies: String = ""

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
                ChatView(userName: userName, userImage: imageName, onBack: {
                    showChat = false
                })
            } else {
                MainTabView(
                    onStartChat: {
                        showChat = true
                    },
                    userName: userName,
                    imageName: imageName,
                    hobbies: hobbies
                )
            }
        }
    }
}
