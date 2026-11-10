import SwiftUI
import SwiftData

struct TodayView: View {
    @Environment(\.modelContext) private var modelContext

    // @Query keeps this list up to date automatically whenever the database changes.
    @Query(sort: \Habit.createdAt) private var habits: [Habit]

    @State private var viewModel = TodayViewModel()

    var body: some View {
        NavigationStack {
            ScrollView {
                VStack(spacing: 20) {
                    if habits.isEmpty {
                        emptyState
                    } else {
                        ProgressCardView(
                            completed: viewModel.completedCount(in: habits),
                            total: habits.count,
                            message: viewModel.message(
                                completed: viewModel.completedCount(in: habits),
                                total: habits.count
                            )
                        )

                        VStack(spacing: 12) {
                            ForEach(habits) { habit in
                                HabitRowView(
                                    habit: habit,
                                    onOpen: { viewModel.selectedHabit = habit },
                                    onToggle: {
                                        withAnimation {
                                            habit.toggleCompletion(in: modelContext)
                                        }
                                    }
                                )
                                .contextMenu {
                                    Button("Delete", systemImage: "trash", role: .destructive) {
                                        viewModel.habitToDelete = habit
                                    }
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 24)
            }
            .background(Color(.systemGroupedBackground))
            .navigationTitle(viewModel.greeting())
            .toolbar {
                ToolbarItem(placement: .topBarTrailing) {
                    Button {
                        viewModel.showingAddHabit = true
                    } label: {
                        Image(systemName: "plus.circle.fill")
                            .font(.title2)
                    }
                    .accessibilityLabel("Add habit")
                }
            }
            .navigationDestination(item: $viewModel.selectedHabit) { habit in
                HabitDetailView(habit: habit)
            }
            .sheet(isPresented: $viewModel.showingAddHabit) {
                AddHabitView()
            }
            .confirmationDialog(
                "Delete this habit?",
                isPresented: Binding(
                    get: { viewModel.habitToDelete != nil },
                    set: { if !$0 { viewModel.habitToDelete = nil } }
                ),
                titleVisibility: .visible,
                presenting: viewModel.habitToDelete
            ) { habit in
                Button("Delete \(habit.name)", role: .destructive) {
                    viewModel.delete(habit, in: modelContext)
                }
            }
        }
    }

    private var emptyState: some View {
        VStack(spacing: 12) {
            Image(systemName: "leaf.fill")
                .font(.system(size: 44))
                .foregroundStyle(Color.sage)

            Text("No habits yet")
                .font(.title3)
                .fontWeight(.bold)

            Text("Tap the + button to add your first habit.")
                .font(.subheadline)
                .foregroundStyle(.secondary)
                .multilineTextAlignment(.center)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 40)
        .cardStyle()
    }
}

#Preview {
    TodayView()
        .modelContainer(SampleData.container())
}
