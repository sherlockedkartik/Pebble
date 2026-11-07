//
//  AddHabitView.swift
//  Pebble
//
//  Created by Kartik Sharma on 07/11/26.
//

import SwiftUI

struct AddHabitView: View {

    var body: some View {

        VStack(spacing: 10) {

            Text("Add New Habit")
                .font(.title)
                .fontWeight(.bold)

            Text("Create a new habit to track")
                .font(.caption)
                .foregroundStyle(.secondary)

            Spacer()
        }
        .padding()
       
    }
}

#Preview {
    NavigationStack {
        AddHabitView()
    }
}
