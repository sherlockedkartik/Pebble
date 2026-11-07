//
//  SectionHeader.swift
//  Pebble
//
//  Created by Kartik Sharma on 07/11/26.
//



import SwiftUI

struct SectionHeader: View {

    let title: String

    var body: some View {
        Text(title)
            .font(.title2)
            .fontWeight(.bold)
    }
}

#Preview {
    SectionHeader(title: "Today's Habits")
}
