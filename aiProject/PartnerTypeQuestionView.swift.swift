// опрос с аи

import SwiftUI

struct PartnerTypeQuestionView: View {
    @Binding var selectedPartnerType: String?
    var currentQuestion: Int
    var totalQuestions: Int
    var nextAction: () -> Void

    var body: some View {
        QuestionView(
            title: "What type of partner AI do you want to create?",
            options: ["Romantic", "Friendly", "Supportive", "Intellectual"],
            selectedOption: $selectedPartnerType,
            currentQuestion: currentQuestion,
            totalQuestions: totalQuestions,
            nextAction: nextAction
        )
    }
}
