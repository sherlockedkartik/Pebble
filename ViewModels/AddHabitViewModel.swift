import Foundation
import Observation

/// State and validation for the "New Habit" form.
@Observable
class AddHabitViewModel {
    static let maxNameLength = 30

    var name = ""
    var selectedIcon = HabitIcon.all[0]
    var selectedColor = HabitColor.sage

    var trimmedName: String {
        name.trimmingCharacters(in: .whitespacesAndNewlines)
    }

    /// The Save button is only enabled when this is true.
    var isValid: Bool {
        !trimmedName.isEmpty && trimmedName.count <= Self.maxNameLength
    }

    var validationMessage: String? {
        if trimmedName.count > Self.maxNameLength {
            return "Keep the name under \(Self.maxNameLength) characters."
        }
        return nil
    }

    /// Returns a new Habit, or nil if the form isn't valid.
    func makeHabit() -> Habit? {
        guard isValid else { return nil }
        return Habit(name: trimmedName, icon: selectedIcon, colorName: selectedColor.rawValue)
    }
}
