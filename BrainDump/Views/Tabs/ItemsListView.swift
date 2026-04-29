import SwiftUI
import UIKit

struct ItemsListView: View {
    @EnvironmentObject private var store: BrainDumpStore
    @State private var detailItem: FlowItem?
    @State private var typeFilter: FlowItemType? = nil

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("\(store.weekCount) items deze week")
                .font(.system(size: 17))
                .foregroundStyle(FN.secondary)
                .padding(.horizontal, 24)
                .padding(.top, 8)
                .padding(.bottom, 12)

            ScrollView(.horizontal, showsIndicators: false) {
                HStack(spacing: 8) {
                    filterPill(label: "Alles", icon: "square.grid.2x2", active: typeFilter == nil) {
                        withAnimation(.spring(response: 0.25, dampingFraction: 0.7)) { typeFilter = nil }
                    }
                    ForEach(FlowItemType.allCases) { type in
                        filterPill(label: type.label, icon: type.icon, active: typeFilter == type, color: type.color) {
                            withAnimation(.spring(response: 0.25, dampingFraction: 0.7)) {
                                typeFilter = typeFilter == type ? nil : type
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 14)
            }

            ScrollView {
                LazyVStack(alignment: .leading, spacing: 10) {
                    WeeklyStatsCard()
                        .padding(.bottom, 6)

                    ForEach(groupedItems, id: \.title) { group in
                        SectionLabel(group.title)
                            .padding(.horizontal, 4)
                            .padding(.top, group.title == groupedItems.first?.title ? 0 : 12)
                        ForEach(group.items) { item in
                            Button { detailItem = item } label: {
                                ItemCard(item: item)
                            }
                            .buttonStyle(.plain)
                            .swipeActions(edge: .leading, allowsFullSwipe: true) {
                                Button {
                                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                                    withAnimation { store.setStatus(item, status: .completed) }
                                } label: {
                                    Label("Klaar", systemImage: FlowItemStatus.completed.icon)
                                }
                                .tint(FlowItemStatus.completed.color)

                                Button {
                                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                                    withAnimation { store.setStatus(item, status: .saved) }
                                } label: {
                                    Label("Bewaar", systemImage: FlowItemStatus.saved.icon)
                                }
                                .tint(FlowItemStatus.saved.color)
                            }
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button(role: .destructive) {
                                    UINotificationFeedbackGenerator().notificationOccurred(.warning)
                                    store.delete(item)
                                } label: {
                                    Label("Weg", systemImage: "trash.fill")
                                }
                            }
                        }
                    }
                }
                .padding(.horizontal, 20)
                .padding(.bottom, 16)
            }
        }
        .sheet(item: $detailItem) { item in
            ItemDetailView(item: item)
        }
    }

    private var groupedItems: [(title: String, items: [FlowItem])] {
        let filtered = store.items.filter { typeFilter == nil || $0.type == typeFilter }
        let sorted = filtered.sorted { $0.createdAt > $1.createdAt }
        let grouped = Dictionary(grouping: sorted) { Calendar.current.startOfDay(for: $0.createdAt) }
        return grouped.keys.sorted(by: >).map { day in
            let title: String
            if Calendar.current.isDateInToday(day) {
                title = "Vandaag"
            } else if Calendar.current.isDateInYesterday(day) {
                title = "Gisteren"
            } else {
                title = day.formatted(.dateTime.day().month(.wide).locale(Locale(identifier: "nl_BE"))).capitalized
            }
            return (title, grouped[day] ?? [])
        }
    }

    @ViewBuilder
    private func filterPill(label: String, icon: String, active: Bool, color: Color = FN.ink, action: @escaping () -> Void) -> some View {
        Button(action: action) {
            HStack(spacing: 6) {
                Image(systemName: icon)
                Text(label)
            }
            .font(.system(size: 15, weight: .medium))
            .foregroundStyle(active ? color : FN.secondary)
            .padding(.horizontal, 14)
            .padding(.vertical, 9)
            .background(active ? color.opacity(0.12) : FN.surface)
            .clipShape(RoundedRectangle(cornerRadius: 12))
            .overlay(
                RoundedRectangle(cornerRadius: 12)
                    .stroke(active ? color.opacity(0.35) : Color.clear, lineWidth: 1.5)
            )
        }
        .buttonStyle(.plain)
    }
}
