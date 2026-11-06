//
//  ContentView.swift
//  Pebble
//
//  Created by Kartik Sharma on 05/11/26.
//

import SwiftUI

struct ContentView: View {
    let habits = [
        Habit(name: "Morning Workout", icon: "dumbbell.fill", category: "Fitness", streak: 14, isCompleted: true),
        Habit(name: "Read 20 Pages", icon: "book.fill", category: "Learning", streak: 28, isCompleted: false)
    ]

    var body: some View {
        ScrollView {
            LazyVStack(spacing: 12) {
                ForEach(habits) { habit in
                    HabitRow(habit: habit)
                }
            }
            .padding(.horizontal, 20)
        }
    }
}
#Preview {
    ContentView()
}
