import SwiftUI

struct WeeklyStatsCard: View {
    @EnvironmentObject private var store: BrainDumpStore

    private var completionRate: Double {
        guard store.weekCount > 0 else { return 0 }
        return Double(store.weekProcessedCount) / Double(store.weekCount)
    }

    private var maxDayCount: Int {
        max(store.weekDayCounts.max() ?? 1, 1)
    }

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            HStack(alignment: .top) {
                VStack(alignment: .leading, spacing: 2) {
                    Text("\(store.weekCount)")
                        .font(.system(size: 36, weight: .semibold))
                        .foregroundStyle(FN.ink)
                    Text("gedumpt")
                        .font(.system(size: 15))
                        .foregroundStyle(FN.secondary)
                }
                Spacer()
                VStack(alignment: .trailing, spacing: 2) {
                    Text("\(store.weekProcessedCount)")
                        .font(.system(size: 36, weight: .semibold))
                        .foregroundStyle(FN.ink)
                    Text("verwerkt")
                        .font(.system(size: 15))
                        .foregroundStyle(FN.secondary)
                }
            }

            GeometryReader { proxy in
                ZStack(alignment: .leading) {
                    Capsule().fill(FN.line)
                    Capsule()
                        .fill(FN.success)
                        .frame(width: max(0, proxy.size.width * completionRate))
                }
            }
            .frame(height: 6)

            HStack(alignment: .bottom, spacing: 6) {
                ForEach(Array(store.weekDayCounts.enumerated()), id: \.offset) { _, count in
                    let height = count == 0 ? 4.0 : max(8, 44 * Double(count) / Double(maxDayCount))
                    RoundedRectangle(cornerRadius: 4)
                        .fill(count == 0 ? FN.line : FN.ink.opacity(0.15))
                        .frame(maxWidth: .infinity)
                        .frame(height: height)
                }
            }
            .frame(height: 44)
        }
        .padding(20)
        .background(FN.surface)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
