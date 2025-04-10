import SwiftUI

struct HobbiesQuestionView: View {
    @Binding var selectedHobbies: Set<String>
    var currentQuestion: Int
    var totalQuestions: Int
    var nextAction: () -> Void
    
    let options: [String] = [
        "Traveling", "Movies", "Animals", "Photography",
        "Yoga", "Art & Drawing", "Dancing", "Reading", "Cooking"
    ]
    
    var body: some View {
        QuestionView(
            title: "What are your hobbies?",
            options: options,
            selectedOption: Binding(
                get: { selectedHobbies.first },
                set: { newValue in
                    if let value = newValue {
                        if selectedHobbies.contains(value) {
                            selectedHobbies.remove(value)
                        } else {
                            selectedHobbies.insert(value)
                        }
                    }
                }
            ),
            currentQuestion: currentQuestion,
            totalQuestions: totalQuestions,
            nextAction: nextAction
        )
    }
}
