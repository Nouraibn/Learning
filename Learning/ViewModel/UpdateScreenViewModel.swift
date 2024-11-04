
import SwiftUI

class UpdateScreenViewModel: ObservableObject {
    @Published var text: String = ""
    @Published var selectedChoice: String? = nil
    @Published var defaultFreezeDays: Int = 0
    @Published var isNavigating: Bool = false
    
    // Set freeze days based on selected time frame
    func updateFreezeDays(for choice: String) {
        selectedChoice = choice
        switch choice {
        case "Week":
            defaultFreezeDays = 2
        case "Month":
            defaultFreezeDays = 6
        case "Year":
            defaultFreezeDays = 60
        default:
            defaultFreezeDays = 0
        }
    }
    
    // Generate a LearningGoal based on the current data
    func createLearningGoal() -> LearningGoal {
        return LearningGoal(title: text, defaultFreezeDays: defaultFreezeDays)
    }
}
