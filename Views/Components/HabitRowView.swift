import SwiftUI
import SwiftData

/// One habit in the Today list.
/// Tapping the left side opens the detail screen; tapping the circle checks the habit off.
struct HabitRowView: View {
    let habit: Habit
    let onOpen: () -> Void
    let onToggle: () -> Void

    var body: some View {
        let isDone = habit.isCompleted()
        let streak = habit.currentStreak

        HStack(spacing: 12) {
            Button(action: onOpen) {
                HStack(spacing: 12) {
                    Image(systemName: habit.icon)
                        .font(.title3)
                        .foregroundStyle(habit.color)
                        .frame(width: 44, height: 44)
                        .background(
                            habit.color.opacity(0.15),
                            in: RoundedRectangle(cornerRadius: 14, style: .continuous)
                        )

                    VStack(alignment: .leading, spacing: 2) {
                        Text(habit.name)
                            .font(.headline)
                            .strikethrough(isDone)
                            .foregroundStyle(isDone ? .secondary : .primary)

                        if streak > 0 {
                            // Amber is only for streaks of a week or more.
                            Label("\(streak) day streak", systemImage: "flame.fill")
                                .font(.caption)
                                .foregroundStyle(streak >= 7 ? Color.amber : Color.secondary)
                        }
                    }
                    Spacer()
                }
                .contentShape(Rectangle())
            }
            .buttonStyle(.plain)
            .accessibilityHint("Opens habit details")

            Button(action: onToggle) {
                Image(systemName: isDone ? "checkmark.circle.fill" : "circle")
                    .font(.title)
                    .foregroundStyle(isDone ? habit.color : Color.secondary)
                    .frame(width: 44, height: 44)
            }
            .buttonStyle(.plain)
            .accessibilityLabel(isDone ? "Mark \(habit.name) as not done" : "Mark \(habit.name) as done")
        }
        .cardStyle()
        .animation(.spring(response: 0.35, dampingFraction: 0.7), value: isDone)
        .sensoryFeedback(.success, trigger: isDone)
    }
}

#Preview {
    let container = SampleData.container()
    let habit = (try? ModelContext(container).fetch(FetchDescriptor<Habit>()))?.first
    return VStack {
        if let habit {
            HabitRowView(habit: habit, onOpen: {}, onToggle: {})
        }
    }
    .padding()
    .background(Color(.systemGroupedBackground))
    .modelContainer(container)
}
