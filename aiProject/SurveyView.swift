// сервисный код для опросов

import SwiftUI

struct SurveyView: View {
    @AppStorage("userName") private var storedUserName: String = ""
    @AppStorage("imageName") private var storedImageName: String = ""
    @AppStorage("hobbies") private var storedHobbies: String = ""

    @State private var currentQuestion = 1
    @State private var selectedGender: String? = nil
    @State private var selectedOrientation: String? = nil
    @State private var selectedPartnerType: String? = nil
    @State private var selectedHobbies: Set<String> = []
    @State private var selectedAppearance: String? = nil
    @State private var userName: String = ""

    let totalQuestions = 6

    var surveyCompleted: () -> Void

    var body: some View {
        ZStack {
            Color.black.ignoresSafeArea()

            VStack {
                Spacer()

                switch currentQuestion {
                case 1:
                    QuestionView(
                        title: "What gender are you?",
                        options: ["Male", "Female", "Non-binary", "Other"],
                        selectedOption: $selectedGender,
                        currentQuestion: currentQuestion,
                        totalQuestions: totalQuestions,
                        nextAction: {
                            if selectedGender != nil { moveToNextQuestion() }
                        }
                    )
                case 2:
                    QuestionView(
                        title: "What is your orientation?",
                        options: ["Heterosexual", "Homosexual", "Bisexual", "Asexual", "Other"],
                        selectedOption: $selectedOrientation,
                        currentQuestion: currentQuestion,
                        totalQuestions: totalQuestions,
                        nextAction: {
                            if selectedOrientation != nil { moveToNextQuestion() }
                        }
                    )
                case 3:
                    QuestionView(
                        title: "What type of partner AI do you want to create?",
                        options: ["Romantic", "Friendly", "Supportive", "Intellectual"],
                        selectedOption: $selectedPartnerType,
                        currentQuestion: currentQuestion,
                        totalQuestions: totalQuestions,
                        nextAction: {
                            if selectedPartnerType != nil { moveToNextQuestion() }
                        }
                    )
                case 4:
                    HobbiesQuestionView(
                        selectedHobbies: $selectedHobbies,
                        currentQuestion: currentQuestion,
                        totalQuestions: totalQuestions,
                        nextAction: {
                            if !selectedHobbies.isEmpty { moveToNextQuestion() }
                        }
                    )
                case 5:
                    AppearanceQuestionView(
                        selectedAppearance: $selectedAppearance,
                        currentQuestion: currentQuestion,
                        totalQuestions: totalQuestions,
                        nextAction: {
                            if selectedAppearance != nil { moveToNextQuestion() }
                        }
                    )
                case 6:
                    NameQuestionView(
                        userName: $userName,
                        currentQuestion: currentQuestion,
                        totalQuestions: totalQuestions,
                        nextAction: {
                            if !userName.isEmpty {
                                storedUserName = userName
                                storedImageName = selectedAppearance ?? "appearance1"
                                storedHobbies = selectedHobbies.joined(separator: ",")
                                surveyCompleted()
                            }
                        }
                    )
                default:
                    EmptyView()
                }

                Spacer()
            }
        }
    }

    private func moveToNextQuestion() {
        withAnimation {
            if currentQuestion < totalQuestions {
                currentQuestion += 1
            }
        }
    }
}
