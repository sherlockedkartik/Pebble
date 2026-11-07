//
//  HabitRow.swift
//  Pebble
//
//  Created by Kartik Sharma on 06/11/26.
//

import SwiftUI

struct HabitRow: View {
    @Binding var habit: Habit

    var body: some View {
        HStack(spacing: 12) {
            Image(systemName: habit.icon)
                .font(.title3)
                .foregroundStyle(.green)
                .frame(width: 44, height: 44)
                .background(Color.green.opacity(0.2), in: Circle())

            VStack(alignment: .leading, spacing: 2) {
                Text(habit.name)
                    .font(.headline)

                Text("\(habit.category) · \(habit.streak) day streak")
                    .font(.caption)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            Button {
                habit.isCompleted.toggle()
            } label: {
                Image(
                    systemName: habit.isCompleted
                    ? "checkmark.circle.fill"
                    : "circle"
                )
                .font(.title)
                .foregroundStyle(
                    habit.isCompleted ? .green : .gray
                )
            }
            .buttonStyle(.plain)
        }
        .pebbleCardStyle()
    }
}

#Preview {
    HabitRow(
        habit: .constant(
            Habit(
                name: "Morning Workout",
                icon: "dumbbell.fill",
                category: "Fitness",
                streak: 14,
                isCompleted: true
            )
        )
    )
    .padding(.horizontal, 20)
}
