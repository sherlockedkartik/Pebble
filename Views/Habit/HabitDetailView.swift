import SwiftUI
import SwiftData

/// Shows one habit's streaks and its last 4 weeks of history.
struct HabitDetailView: View {
    let habit: Habit

    private let gridColumns = Array(repeating: GridItem(.flexible(), spacing: 8), count: 7)

    /// The last 28 days, oldest first.
    private var last28Days: [Date] {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        return (0..<28).reversed().compactMap { daysAgo in
            calendar.date(byAdding: .day, value: -daysAgo, to: today)
        }
    }

    var body: some View {
        ScrollView {
            VStack(spacing: 20) {
                header

                HStack(spacing: 12) {
                    StatCardView(
                        title: "Current streak",
                        value: "\(habit.currentStreak)",
                        systemImage: "flame.fill",
                        tint: habit.currentStreak >= 7 ? Color.amber : habit.color
                    )
                    StatCardView(
                        title: "Best streak",
                        value: "\(habit.bestStreak)",
                        systemImage: "trophy.fill",
                        tint: habit.color
                    )
                    StatCardView(
                        title: "Total days",
                        value: "\(habit.completions.count)",
                        systemImage: "checkmark.circle.fill",
                        tint: habit.color
                    )
                }

                historyCard
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 24)
        }
        .background(Color(.systemGroupedBackground))
        .navigationTitle(habit.name)
        .navigationBarTitleDisplayMode(.inline)
    }

    private var header: some View {
        VStack(spacing: 10) {
            Image(systemName: habit.icon)
                .font(.system(size: 34))
                .foregroundStyle(habit.color)
                .frame(width: 80, height: 80)
                .background(
                    habit.color.opacity(0.15),
                    in: RoundedRectangle(cornerRadius: 24, style: .continuous)
                )
                .accessibilityHidden(true)

            Text(habit.name)
                .font(.title2)
                .fontWeight(.bold)

            Text("Started \(habit.createdAt.formatted(date: .abbreviated, time: .omitted))")
                .font(.subheadline)
                .foregroundStyle(.secondary)
        }
        .padding(.top, 8)
    }

    private var historyCard: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Last 28 days")
                .font(.headline)

            LazyVGrid(columns: gridColumns, spacing: 8) {
                ForEach(last28Days, id: \.self) { day in
                    dayCell(day)
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .cardStyle()
    }

    private func dayCell(_ day: Date) -> some View {
        let isDone = habit.isCompleted(on: day)
        let dayNumber = Calendar.current.component(.day, from: day)

        return Text("\(dayNumber)")
            .font(.caption)
            .fontWeight(.medium)
            .foregroundStyle(isDone ? Color.white : Color.secondary)
            .frame(maxWidth: .infinity)
            .aspectRatio(1, contentMode: .fit)
            .background(
                isDone ? habit.color : Color(.tertiarySystemFill),
                in: RoundedRectangle(cornerRadius: 10, style: .continuous)
            )
            .accessibilityLabel(day.formatted(date: .complete, time: .omitted) + (isDone ? ", done" : ", not done"))
    }
}

#Preview {
    let container = SampleData.container()
    let habit = (try? ModelContext(container).fetch(FetchDescriptor<Habit>()))?.first
    return NavigationStack {
        if let habit {
            HabitDetailView(habit: habit)
        }
    }
    .modelContainer(container)
}
