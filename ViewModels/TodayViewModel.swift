import Foundation
import Observation
import SwiftData

/// Holds the Today screen's state and the little bits of logic it needs.
/// The habits themselves come from @Query in the view, so there is only one source of truth.
@Observable
class TodayViewModel {
    var showingAddHabit = false
    var selectedHabit: Habit?       // set when the user taps a habit to open its detail
    var habitToDelete: Habit?       // set when the user asks to delete (we confirm first)

    func greeting(at date: Date = Date()) -> String {
        let hour = Calendar.current.component(.hour, from: date)
        switch hour {
        case 5..<12: return "Good morning"
        case 12..<17: return "Good afternoon"
        default: return "Good evening"
        }
    }

    func completedCount(in habits: [Habit]) -> Int {
        habits.filter { $0.isCompleted() }.count
    }

    func message(completed: Int, total: Int) -> String {
        if total == 0 { return "Add a habit to get started." }
        if completed == total { return "All done. Great work!" }
        if completed == 0 { return "A fresh day. Start small." }
        return "\(total - completed) to go. Keep it up!"
    }

    func delete(_ habit: Habit, in context: ModelContext) {
        context.delete(habit)
        habitToDelete = nil
    }
}
