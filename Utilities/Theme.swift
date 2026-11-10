import SwiftUI

extension Color {
    init(hex: UInt32) {
        self.init(
            red: Double((hex >> 16) & 0xFF) / 255,
            green: Double((hex >> 8) & 0xFF) / 255,
            blue: Double(hex & 0xFF) / 255
        )
    }

    /// Main brand color.
    static let sage = Color(hex: 0x91C987)

    /// Only used for streaks of 7 days or more.
    static let amber = Color(hex: 0xE0A85C)
}

/// Colors a user can pick for a habit.
enum HabitColor: String, CaseIterable, Identifiable {
    case sage, sky, lavender, rose, coral, teal

    var id: String { rawValue }

    var color: Color {
        switch self {
        case .sage: return Color.sage
        case .sky: return Color(hex: 0x6EC1F4)
        case .lavender: return Color(hex: 0xBAA3F3)
        case .rose: return Color(hex: 0xF48EB0)
        case .coral: return Color(hex: 0xF58A6E)
        case .teal: return Color(hex: 0x4ECDC4)
        }
    }
}

/// SF Symbols a user can pick for a habit.
enum HabitIcon {
    static let all = [
        "book.fill", "drop.fill", "figure.run", "moon.fill",
        "heart.fill", "leaf.fill", "dumbbell.fill", "pencil"
    ]
}

/// Light / dark / follow the phone.
enum AppearanceMode: String, CaseIterable, Identifiable {
    case system, light, dark

    var id: String { rawValue }

    var title: String {
        rawValue.capitalized
    }

    /// nil means "use the system setting".
    var colorScheme: ColorScheme? {
        switch self {
        case .system: return nil
        case .light: return .light
        case .dark: return .dark
        }
    }
}
