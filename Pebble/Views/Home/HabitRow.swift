//
//  HabitRow.swift
//  Pebble
//
//  Created by Kartik Sharma on 06/11/26.
//

import SwiftUI

struct HabitRow: View {
    let habit: Habit

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

            Image(systemName: habit.isCompleted ? "checkmark.circle.fill" : "circle")
                .font(.title)
                .foregroundStyle(habit.isCompleted ? .green : .secondary)
        }
        .padding(16)
        .background(Color(.secondarySystemBackground), in: RoundedRectangle(cornerRadius: 24))
    }
}

#Preview {
    HabitRow(habit: Habit(name: "Morning Workout", icon: "dumbbell.fill", category: "Fitness", streak: 14, isCompleted: true))
        .padding(.horizontal, 20)
}
