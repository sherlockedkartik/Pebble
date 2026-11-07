//
//  Habit.swift
//  Pebble
//
//  Created by Kartik Sharma on 06/11/26.
//


import Foundation

struct Habit: Identifiable {
    var id = UUID()

    var name: String
    var icon: String
    var category: HabitCategory
    var frequency: HabitFrequency

    var streak: Int
    var isCompleted: Bool
}
