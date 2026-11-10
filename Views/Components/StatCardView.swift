import SwiftUI

/// A small card with an icon, a big number and a label. Used on Detail and Stats.
struct StatCardView: View {
    let title: String
    let value: String
    let systemImage: String
    var tint: Color = Color.sage

    var body: some View {
        VStack(alignment: .leading, spacing: 6) {
            Image(systemName: systemImage)
                .foregroundStyle(tint)

            Text(value)
                .font(.title)
                .fontWeight(.bold)

            Text(title)
                .font(.caption)
                .foregroundStyle(.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .cardStyle()
        .accessibilityElement(children: .combine)
    }
}

#Preview {
    HStack {
        StatCardView(title: "Current streak", value: "12", systemImage: "flame.fill", tint: Color.amber)
        StatCardView(title: "Best streak", value: "30", systemImage: "trophy.fill")
    }
    .padding()
    .background(Color(.systemGroupedBackground))
}
