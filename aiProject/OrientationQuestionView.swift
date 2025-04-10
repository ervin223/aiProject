import SwiftUI

struct OrientationQuestionView: View {
    @Binding var selectedOrientation: String?
    var currentQuestion: Int
    var totalQuestions: Int
    var nextAction: () -> Void

    var body: some View {
        QuestionView(
            title: "What is your orientation?",
            options: ["Heterosexual", "Homosexual", "Bisexual", "Asexual", "Other"],
            selectedOption: $selectedOrientation,
            currentQuestion: currentQuestion,
            totalQuestions: totalQuestions,
            nextAction: nextAction
        )
    }
}
