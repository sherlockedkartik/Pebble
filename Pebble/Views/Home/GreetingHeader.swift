//
//  GreetingHeader.swift
//  Pebble
//
//  Created by Kartik Sharma on 06/11/26.
//


import SwiftUI

struct GreetingHeader: View {
    var body: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("WEDNESDAY, NOV 5")
                .font(.caption)
                .fontWeight(.semibold)
                .foregroundStyle(.secondary)

            Text("Good morning, Kartik")
                .font(.largeTitle)
                .fontWeight(.bold)
        }
    }
}

#Preview {
    GreetingHeader()
}