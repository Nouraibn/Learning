import Foundation

extension Date {
    
    static var capitalizedFirstThreeLettersOfWeekdays: [String] {
        let calendar = Calendar.current
        let weekdays = calendar.shortWeekdaySymbols
        
        return weekdays.compactMap { weekday in
            let firstThreeLetters = String(weekday.prefix(3)) // Get the first three letters
            return firstThreeLetters.uppercased() // Capitalize them
        }
    }
    
    static var fullMonthNames: [String] {
        let dateFormatter = DateFormatter()
        dateFormatter.locale = Locale.current
        dateFormatter.dateFormat = "MMMM" // Set format to full month name
        
        return (1...12).compactMap { month in
            let date = Calendar.current.date(from: DateComponents(year: 2000, month: month, day: 1))
            return date.map { dateFormatter.string(from: $0) }
        }
    }
    var startOfMonth: Date {
        
        Calendar.current.dateInterval(of: .month, for: self)!.start
    }
    var endOfMonth: Date {
        
        Calendar.current.dateInterval(of: .month, for: self)!.end
    }
    var startOfPreviousMonth: Date {
        let dayInPreviousMonth = Calendar.current.date(byAdding: .month, value: -1, to: self)!
        return dayInPreviousMonth.startOfMonth
    }
    var numberOfDaysInMonth: Int {
        Calendar.current.component(.day, from: endOfMonth)
    }
    
    var sundayBeforeStart: Date {
        let startOfMonthWeekday = Calendar.current.component(.weekday, from: startOfMonth)
        let numberFromPreviousMonth = startOfMonthWeekday
        return Calendar.current.date(byAdding: .day, value: -numberFromPreviousMonth, to: startOfMonth)!
    }
    
    var calendarDisplayDays: [Date] {
        var days: [Date] = []
        // Current month days
        for dayOffset in 0..<numberOfDaysInMonth {
            let newDay = Calendar.current.date (byAdding: .day, value: dayOffset, to: startOfMonth)
            days.append(newDay!)
        }
            // previous month days
        for dayOffset in 0..<startOfPreviousMonth.numberOfDaysInMonth {
            let newDay = Calendar.current.date (byAdding: .day, value: dayOffset, to: startOfPreviousMonth)
            days.append(newDay!)
        }
                return days.filter { $0 >= sundayBeforeStart && $0 <= endOfMonth }.sorted(by:<)
            }
    var monthIn: Int {
        Calendar.current.component(.month, from: self)
    }
    
    var startOfDay: Date {
        Calendar.current.startOfDay(for: self)
    }
        }
    


