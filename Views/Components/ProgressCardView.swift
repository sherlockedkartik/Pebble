import SwiftUI

/// The card at the top of Today: date, "3 of 5 done" and a progress ring.
struct ProgressCardView: View {
    let completed: Int
    let total: Int
    let message: String

    private var progress: Double {
        total == 0 ? 0 : Double(completed) / Double(total)
    }

    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 6) {
                Text(Date().formatted(.dateTime.weekday(.wide).month(.abbreviated).day()))
                    .font(.caption)
                    .fontWeight(.semibold)
                    .textCase(.uppercase)
                    .foregroundStyle(.secondary)

                Text("\(completed) of \(total) done")
                    .font(.title2)
                    .fontWeight(.bold)

                Text(message)
                    .font(.subheadline)
                    .foregroundStyle(.secondary)
            }

            Spacer()

            ZStack {
                Circle()
                    .stroke(Color.sage.opacity(0.2), lineWidth: 10)
                Circle()
                    .trim(from: 0, to: progress)
                    .stroke(Color.sage, style: StrokeStyle(lineWidth: 10, lineCap: .round))
                    .rotationEffect(.degrees(-90))
                Text("\(Int(progress * 100))%")
                    .font(.headline)
            }
            .frame(width: 80, height: 80)
            .animation(.easeInOut(duration: 0.5), value: progress)
        }
        .cardStyle()
        .accessibilityElement(children: .combine)
    }
}

#Preview {
    ProgressCardView(completed: 2, total: 3, message: "1 to go. Keep it up!")
        .padding()
        .background(Color(.systemGroupedBackground))
}
