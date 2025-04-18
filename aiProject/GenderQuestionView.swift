// опрос с гендерами

import SwiftUI

struct GenderQuestionView: View {
    @Binding var selectedGender: String?
    var currentQuestion: Int
    var totalQuestions: Int
    var nextAction: () -> Void

    var body: some View {
        QuestionView(
            title: "What gender are you?",
            options: ["Male", "Female", "Non-binary", "Other"],
            selectedOption: $selectedGender,
            currentQuestion: currentQuestion,
            totalQuestions: totalQuestions,
            nextAction: nextAction
        )
    }
}
