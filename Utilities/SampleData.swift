import Foundation
import SwiftData

/// Fake data so SwiftUI previews have something to show. The real app never calls this.
enum SampleData {
    static func container() -> ModelContainer {
        do {
            let container = try ModelContainer(
                for: Habit.self, HabitCompletion.self,
                configurations: ModelConfiguration(isStoredInMemoryOnly: true)
            )
            let context = ModelContext(container)

            let habits = [
                Habit(name: "Morning Workout", icon: "dumbbell.fill", colorName: "sage"),
                Habit(name: "Read 20 Pages", icon: "book.fill", colorName: "lavender"),
                Habit(name: "Drink Water", icon: "drop.fill", colorName: "sky")
            ]

            for (index, habit) in habits.enumerated() {
                context.insert(habit)
                for daysAgo in 0..<30 where (daysAgo + index) % 4 != 3 {
                    let day = Calendar.current.date(byAdding: .day, value: -daysAgo, to: Date()) ?? Date()
                    let completion = HabitCompletion(date: day)
                    context.insert(completion)
                    habit.completions.append(completion)
                }
            }
            try context.save()
            return container
        } catch {
            fatalError("Could not create preview data: \(error)")
        }
    }
}
