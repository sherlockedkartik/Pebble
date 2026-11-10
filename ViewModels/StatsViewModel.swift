import Foundation

/// One bar in the weekly chart.
struct DayCount: Identifiable {
    let date: Date
    let label: String       // "Mon", "Tue", ...
    let count: Int

    var id: Date { date }
}

/// Works out the numbers on the Stats screen. It has no stored state, so it's a simple struct.
struct StatsViewModel {

    /// How many habits were completed on each of the last 7 days (oldest first).
    func last7Days(habits: [Habit]) -> [DayCount] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())

        return (0..<7).reversed().compactMap { daysAgo in
            guard let day = calendar.date(byAdding: .day, value: -daysAgo, to: today) else { return nil }
            let count = habits.filter { $0.isCompleted(on: day) }.count
            return DayCount(date: day, label: day.formatted(.dateTime.weekday(.abbreviated)), count: count)
        }
    }

    func totalCompletions(habits: [Habit]) -> Int {
        habits.reduce(0) { $0 + $1.completions.count }
    }

    func bestStreak(habits: [Habit]) -> Int {
        habits.map { $0.bestStreak }.max() ?? 0
    }

    /// Percentage of possible check-ins done in the last 7 days.
    func weeklyRate(habits: [Habit]) -> Int {
        guard !habits.isEmpty else { return 0 }
        let done = last7Days(habits: habits).reduce(0) { $0 + $1.count }
        let possible = habits.count * 7
        return Int((Double(done) / Double(possible) * 100).rounded())
    }
}
