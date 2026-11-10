import SwiftUI
import SwiftData
import Charts

struct StatsView: View {
    @Query(sort: \Habit.createdAt) private var habits: [Habit]

    private let viewModel = StatsViewModel()

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    if habits.isEmpty {
                        Text("Add a habit and check it off to see your stats here.")
                            .font(.subheadline)
                            .foregroundStyle(.secondary)
                            .multilineTextAlignment(.center)
                            .frame(maxWidth: .infinity)
                            .padding(.vertical, 40)
                            .cardStyle()
                    } else {
                        tiles
                        weeklyChart
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 24)
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle("Stats")
        }
    }

    private var tiles: some View {
        HStack(spacing: 12) {
            StatCardView(
                title: "This week",
                value: "\(viewModel.weeklyRate(habits: habits))%",
                systemImage: "calendar"
            )
            StatCardView(
                title: "Best streak",
                value: "\(viewModel.bestStreak(habits: habits))",
                systemImage: "trophy.fill"
            )
            StatCardView(
                title: "Check-ins",
                value: "\(viewModel.totalCompletions(habits: habits))",
                systemImage: "checkmark.circle.fill"
            )
        }
    }

    private var weeklyChart: some View {
        VStack(alignment: .leading, spacing: 12) {
            Text("Last 7 days")
                .font(.headline)

            Chart(viewModel.last7Days(habits: habits)) { day in
                BarMark(
                    x: .value("Day", day.label),
                    y: .value("Habits done", day.count)
                )
                .foregroundStyle(Color.sage)
                .cornerRadius(6)
            }
            .frame(height: 200)
            .accessibilityLabel("Bar chart of habits completed in the last 7 days")
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .cardStyle()
    }
}

#Preview {
    StatsView()
        .modelContainer(SampleData.container())
}
