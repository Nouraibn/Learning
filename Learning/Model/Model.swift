import SwiftUI

enum LearningOption: String {
    case week = "Week"
    case month = "Month"
    case year = "Year"
    
    var defaultFreezeDays: Int {
        switch self {
        case .week:
            return 2
        case .month:
            return 6
        case .year:
            return 60
        }
    }
}

enum LogStatus: Int {
    case none = 0
    case logged = 1
    case frozen = 2
}

struct LearningGoal {
    var title: String
    var defaultFreezeDays: Int
}

