//
//  Habit.swift
//  Pebble
//
//  Created by Kartik Sharma on 06/11/26.
//


import Foundation

struct Habit: Identifiable {
    let id = UUID()
    let name: String
    let icon: String
    let category: String
    var streak: Int
    var isCompleted: Bool
}
