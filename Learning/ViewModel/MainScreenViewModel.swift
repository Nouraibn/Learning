
import SwiftUI
import Combine

class MainViewModel: ObservableObject {
    @Published var date = Date.now
    @Published var days: [Date] = []
    @Published var logCount = 0
    @Published var freezeCount = 0
    @Published var isTodayLogged = false
    @Published var isTodayFrozen = false
    @Published var isCircleLocked = false
    @Published var isRectangleLocked = false
    
    let defaultFreezeDays: Int
    let title: String
    let daysOfWeek = Date.capitalizedFirstThreeLettersOfWeekdays
    let columns = Array(repeating: GridItem(.flexible()), count: 7)
    
    init(title: String, defaultFreezeDays: Int) {
        self.title = title
        self.defaultFreezeDays = defaultFreezeDays
        loadLogStatus()
        updateDisplayedDays()
    }
    
    // Format date to show month and year
    func formattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "MMMM yyyy"
        return formatter.string(from: date)
    }
    
    // Format date to show day of the week and date
    func getFormattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "EEEE, dd MMM"
        return formatter.string(from: date)
    }
    
    // Navigate to the previous or next week
    func navigateWeek(by value: Int) {
        date = Calendar.current.date(byAdding: .weekOfYear, value: value, to: date) ?? date
        updateDisplayedDays()
    }
    
    // Log or unlog today as learned
    func toggleLogToday() {
        if !isCircleLocked {
            if !isTodayLogged {
                isTodayLogged = true
                logCount += 1
                isRectangleLocked = true
                saveLogStatus(for: Date(), status: .logged)
            } else {
                isTodayLogged = false
                logCount = max(logCount - 1, 0)
                isRectangleLocked = false
                saveLogStatus(for: Date(), status: .none)
            }
        }
    }
    
    // Freeze or unfreeze today
    func toggleFreezeToday() {
        if !isRectangleLocked {
            if !isTodayFrozen {
                isTodayFrozen = true
                freezeCount += 1
                isCircleLocked = true
                saveLogStatus(for: Date(), status: .frozen)
            } else {
                isTodayFrozen = false
                freezeCount = max(freezeCount - 1, 0)
                isCircleLocked = false
                saveLogStatus(for: Date(), status: .none)
            }
        }
    }
    
    // Get log status for a specific date
    func getLogStatus(for date: Date) -> LogStatus {
        let key = date.formatted(.dateTime.year().month().day())
        let value = UserDefaults.standard.integer(forKey: key)
        return LogStatus(rawValue: value) ?? .none
    }
    
    // Save log status for a specific date
    func saveLogStatus(for date: Date, status: LogStatus) {
        let key = date.formatted(.dateTime.year().month().day())
        UserDefaults.standard.setValue(status.rawValue, forKey: key)
    }
    
    // Load the current day's log status
    func loadLogStatus() {
        let todayStatus = getLogStatus(for: Date())
        if todayStatus == .logged {
            isTodayLogged = true
            logCount += 1
        } else if todayStatus == .frozen {
            isTodayFrozen = true
            freezeCount += 1
        }
    }
    
    // Update displayed days based on the selected week
    func updateDisplayedDays() {
        days = date.calendarDisplayDays
    }
}
