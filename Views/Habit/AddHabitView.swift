import SwiftUI
import SwiftData

/// The "New Habit" form. Shown as a sheet from the Today screen.
struct AddHabitView: View {
    @Environment(\.modelContext) private var modelContext
    @Environment(\.dismiss) private var dismiss

    @State private var viewModel = AddHabitViewModel()

    private let iconColumns = Array(repeating: GridItem(.flexible()), count: 4)

    var body: some View {
        NavigationStack {
            Form {
                Section("Name") {
                    TextField("e.g. Read 20 pages", text: $viewModel.name)

                    if let message = viewModel.validationMessage {
                        Text(message)
                            .font(.caption)
                            .foregroundStyle(.red)
                    }
                }

                Section("Icon") {
                    LazyVGrid(columns: iconColumns, spacing: 12) {
                        ForEach(HabitIcon.all, id: \.self) { icon in
                            iconButton(icon)
                        }
                    }
                    .padding(.vertical, 4)
                }

                Section("Color") {
                    HStack {
                        ForEach(HabitColor.allCases) { habitColor in
                            colorButton(habitColor)
                            if habitColor != HabitColor.allCases.last {
                                Spacer()
                            }
                        }
                    }
                    .padding(.vertical, 4)
                }
            }
            .navigationTitle("New Habit")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Cancel") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Save") { save() }
                        .disabled(!viewModel.isValid)
                }
            }
        }
        .presentationDetents([.medium, .large])
    }

    private func iconButton(_ icon: String) -> some View {
        let isSelected = viewModel.selectedIcon == icon

        return Button {
            viewModel.selectedIcon = icon
        } label: {
            Image(systemName: icon)
                .font(.title2)
                .foregroundStyle(isSelected ? viewModel.selectedColor.color : Color.secondary)
                .frame(maxWidth: .infinity)
                .frame(height: 52)
                .background(
                    isSelected ? viewModel.selectedColor.color.opacity(0.18) : Color(.tertiarySystemFill),
                    in: RoundedRectangle(cornerRadius: 14, style: .continuous)
                )
        }
        .buttonStyle(.borderless)   // so each button in the Form row can be tapped separately
        .accessibilityLabel(icon.replacingOccurrences(of: ".fill", with: ""))
    }

    private func colorButton(_ habitColor: HabitColor) -> some View {
        let isSelected = viewModel.selectedColor == habitColor

        return Button {
            viewModel.selectedColor = habitColor
        } label: {
            Circle()
                .fill(habitColor.color)
                .frame(width: 34, height: 34)
                .overlay {
                    if isSelected {
                        Image(systemName: "checkmark")
                            .font(.caption)
                            .fontWeight(.bold)
                            .foregroundStyle(.white)
                    }
                }
        }
        .buttonStyle(.borderless)
        .accessibilityLabel(habitColor.rawValue)
    }

    private func save() {
        guard let habit = viewModel.makeHabit() else { return }
        modelContext.insert(habit)
        dismiss()
    }
}

#Preview {
    AddHabitView()
        .modelContainer(SampleData.container())
}
