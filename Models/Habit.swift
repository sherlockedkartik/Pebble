import SwiftUI
import SwiftData

/// A habit the user wants to do every day.
@Model
final class Habit {
    var name: String
    var icon: String        // SF Symbol name, e.g. "book.fill"
    var colorName: String   // matches a case of HabitColor
    var createdAt: Date

    // One habit has many completions. If the habit is deleted, its completions go too.
    @Relationship(deleteRule: .cascade, inverse: \HabitCompletion.habit)
    var completions: [HabitCompletion] = []

    init(name: String, icon: String, colorName: String) {
        self.name = name
        self.icon = icon
        self.colorName = colorName
        self.createdAt = Date()
    }
}

// MARK: - Helpers used by the views

extension Habit {
    var color: Color {
        HabitColor(rawValue: colorName)?.color ?? Color.sage
    }

    var completionDates: [Date] {
        completions.map { $0.date }
    }

    var currentStreak: Int {
        StreakCalculator.currentStreak(from: completionDates)
    }

    var bestStreak: Int {
        StreakCalculator.bestStreak(from: completionDates)
    }

    func isCompleted(on date: Date = Date()) -> Bool {
        completions.contains { Calendar.current.isDate($0.date, inSameDayAs: date) }
    }

    /// Marks the habit done for a day, or undoes it if it was already done.
    /// Checking for an existing record first means we never save two completions for the same day.
    func toggleCompletion(on date: Date = Date(), in context: ModelContext) {
        let existing = completions.first { Calendar.current.isDate($0.date, inSameDayAs: date) }

        if let existing {
            completions.removeAll { $0 === existing }
            context.delete(existing)
        } else {
            let completion = HabitCompletion(date: date)
            context.insert(completion)
            completions.append(completion)
        }
    }
}
