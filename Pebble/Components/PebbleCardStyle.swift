//
//  PebbleCardStyle.swift
//  Pebble
//
//  Created by Kartik Sharma on 07/11/26.
//



import SwiftUI

struct PebbleCardStyle: ViewModifier {

    func body(content: Content) -> some View {
        content
            .padding(16)
            .background(
                Color(.secondarySystemBackground),
                in: RoundedRectangle(cornerRadius: 20)
            )
    }
}

extension View {
    func pebbleCardStyle() -> some View {
        self.modifier(PebbleCardStyle())
    }
}

#Preview {
    Text("Morning Workout")
        .pebbleCardStyle()
        .padding()
}
