import Foundation

/// Streak maths kept separate from SwiftData so it is easy to unit test.
struct StreakCalculator {

    /// How many days in a row the habit was done, counting back from today.
    /// If today isn't done yet, we start from yesterday so the streak isn't lost mid-day.
    static func currentStreak(
        from dates: [Date],
        today: Date = Date(),
        calendar: Calendar = .current
    ) -> Int {
        let days = Set(dates.map { calendar.startOfDay(for: $0) })
        var day = calendar.startOfDay(for: today)

        if !days.contains(day) {
            guard let yesterday = calendar.date(byAdding: .day, value: -1, to: day) else { return 0 }
            day = yesterday
        }

        var streak = 0
        while days.contains(day) {
            streak += 1
            guard let previous = calendar.date(byAdding: .day, value: -1, to: day) else { break }
            day = previous
        }
        return streak
    }

    /// The longest run of consecutive days anywhere in the history.
    static func bestStreak(from dates: [Date], calendar: Calendar = .current) -> Int {
        let sortedDays = Set(dates.map { calendar.startOfDay(for: $0) }).sorted()

        var best = 0
        var run = 0
        var previousDay: Date?

        for day in sortedDays {
            if let previousDay,
               let expectedNext = calendar.date(byAdding: .day, value: 1, to: previousDay),
               expectedNext == day {
                run += 1
            } else {
                run = 1
            }
            best = max(best, run)
            previousDay = day
        }
        return best
    }
}
