import SwiftUI
import SwiftData

@main
struct PebbleApp: App {
    // The user's theme choice is saved automatically in UserDefaults by @AppStorage.
    @AppStorage("appearance") private var appearance: AppearanceMode = .system

    var body: some Scene {
        WindowGroup {
            ContentView()
                .preferredColorScheme(appearance.colorScheme)
        }
        // Creates the SwiftData database and shares it with every view.
        .modelContainer(for: [Habit.self, HabitCompletion.self])
    }
}
