//
//  Test.swift
//  Pebble
//
//  Created by Kartik Sharma on 06/11/26.
//

import SwiftUI

struct Test: View {
    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading) {
                Text("Title")
                Text("Subtitle")
            }
            
            Spacer()
            
            Text("12")
        }
        .padding(20)
    }
}
#Preview {
    Test()
}
