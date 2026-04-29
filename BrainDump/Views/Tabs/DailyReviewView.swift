import SwiftUI

struct DailyReviewView: View {
    @EnvironmentObject private var store: BrainDumpStore

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 8) {
                Text("Wat doe je met\nvandaag?")
                    .font(.system(size: 35, weight: .medium))
                    .lineSpacing(3)
                    .foregroundStyle(FN.ink)
                Text("\(total) items om te verwerken")
                    .font(.system(size: 21))
                    .foregroundStyle(FN.secondary)
                    .padding(.top, 8)
            }
            .padding(.horizontal, 24)
            .padding(.top, 8)

            VStack(alignment: .leading, spacing: 10) {
                GeometryReader { proxy in
                    ZStack(alignment: .leading) {
                        Capsule().fill(FN.surface)
                        Capsule().fill(FN.ink).frame(width: max(0, proxy.size.width * progress))
                    }
                }
                .frame(height: 8)
                Text("\(processed) van \(max(total, 1)) verwerkt")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundStyle(FN.secondary)
            }
            .padding(.horizontal, 24)
            .padding(.top, 20)

            ScrollView {
                VStack(spacing: 14) {
                    if let active = activeItem {
                        ActiveReviewCard(item: active)
                            .id(active.id)
                            .transition(.asymmetric(
                                insertion: .move(edge: .trailing).combined(with: .opacity),
                                removal: .move(edge: .leading).combined(with: .opacity)
                            ))
                    } else {
                        EmptyState(title: "Vandaag is verwerkt", text: "Je mentale inbox is leeg voor vandaag.")
                    }

                    ForEach(nextItems) { item in
                        VStack(alignment: .leading, spacing: 8) {
                            HStack {
                                Text("VOLGENDE · \(time(item.createdAt))")
                                    .font(.system(size: 16, weight: .medium))
                                    .foregroundStyle(FN.secondary)
                                Spacer()
                                if let type = item.type {
                                    HStack(spacing: 4) {
                                        Image(systemName: type.icon)
                                        Text(type.label)
                                    }
                                    .font(.system(size: 12, weight: .medium))
                                    .foregroundStyle(type.color)
                                    .padding(.horizontal, 9)
                                    .padding(.vertical, 4)
                                    .background(type.color.opacity(0.1))
                                    .clipShape(RoundedRectangle(cornerRadius: 7))
                                }
                            }
                            Text(item.text)
                                .font(.system(size: 22))
                                .foregroundStyle(FN.ink)
                        }
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .padding(18)
                        .background(FN.surface)
                        .clipShape(RoundedRectangle(cornerRadius: 18))
                        .opacity(0.85)
                    }

                    ForEach(processedToday) { item in
                        HStack(spacing: 12) {
                            Image(systemName: item.status.icon)
                                .foregroundStyle(item.status.color.opacity(0.6))
                            Text(item.text)
                                .font(.system(size: 20))
                                .strikethrough()
                                .foregroundStyle(FN.secondary)
                            Spacer()
                        }
                        .padding(18)
                        .background(FN.surface)
                        .clipShape(RoundedRectangle(cornerRadius: 18))
                        .opacity(0.55)
                        .transition(.opacity.combined(with: .scale(scale: 0.97)))
                    }
                }
                .padding(.horizontal, 20)
                .padding(.top, 24)
                .padding(.bottom, 20)
            }
        }
    }

    private var openToday: [FlowItem] { store.reviewQueue }
    private var activeItem: FlowItem? { openToday.first }
    private var nextItems: [FlowItem] { Array(openToday.dropFirst().prefix(2)) }
    private var processedToday: [FlowItem] { store.todayItems.filter { $0.status == .completed || $0.status == .saved } }
    private var total: Int { max(store.todayItems.count, 0) }
    private var processed: Int { store.todayItems.filter { $0.status == .completed || $0.status == .saved }.count }
    private var progress: Double { total == 0 ? 1 : Double(processed) / Double(total) }
}
