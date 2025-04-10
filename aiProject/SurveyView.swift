import SwiftUI

struct SurveyView: View {
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
                    GenderQuestionView(selectedGender: $selectedGender, currentQuestion: currentQuestion, totalQuestions: totalQuestions, nextAction: {
                        if let _ = selectedGender { moveToNextQuestion() }
                    })
                case 2:
                    OrientationQuestionView(selectedOrientation: $selectedOrientation, currentQuestion: currentQuestion, totalQuestions: totalQuestions, nextAction: {
                        if let _ = selectedOrientation { moveToNextQuestion() }
                    })
                case 3:
                    PartnerTypeQuestionView(selectedPartnerType: $selectedPartnerType, currentQuestion: currentQuestion, totalQuestions: totalQuestions, nextAction: {
                        if let _ = selectedPartnerType { moveToNextQuestion() }
                    })
                case 4:
                    HobbiesQuestionView(selectedHobbies: $selectedHobbies, currentQuestion: currentQuestion, totalQuestions: totalQuestions, nextAction: {
                        if !selectedHobbies.isEmpty { moveToNextQuestion() }
                    })
                case 5:
                    AppearanceQuestionView(selectedAppearance: $selectedAppearance, currentQuestion: currentQuestion, totalQuestions: totalQuestions, nextAction: {
                        if let _ = selectedAppearance { moveToNextQuestion() }
                    })
                case 6:
                    NameQuestionView(userName: $userName, currentQuestion: currentQuestion, totalQuestions: totalQuestions, nextAction: {
                        if !userName.isEmpty {
                            surveyCompleted()
                        }
                    })
                default:
                    Text("Unknown Question")
                        .foregroundColor(.white)
                }

                Spacer()
            }
            .transition(.opacity)
            .id(currentQuestion)
        }
    }

    private func moveToNextQuestion() {
        DispatchQueue.main.async {
            withAnimation {
                if currentQuestion < totalQuestions { currentQuestion += 1 }
            }
        }
    }
}
