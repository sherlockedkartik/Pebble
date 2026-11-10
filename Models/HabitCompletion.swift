import Foundation
import SwiftData

/// One check-in: "this habit was done on this day".
/// We store a row per day (instead of a single true/false on the habit)
/// so we can work out streaks and show history later.
@Model
final class HabitCompletion {
    var date: Date          // always the start of the day (midnight)
    var habit: Habit?

    init(date: Date) {
        self.date = Calendar.current.startOfDay(for: date)
    }
}
