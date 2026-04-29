import SwiftUI

struct ItemsListView: View {
    @EnvironmentObject private var store: BrainDumpStore
    @State private var detailItem: FlowItem?

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            VStack(alignment: .leading, spacing: 4) {
                Text("Lijst")
                    .font(.system(size: 36, weight: .medium))
                    .foregroundStyle(FN.ink)
                Text("\(store.weekCount) items deze week")
                    .font(.system(size: 22))
                    .foregroundStyle(FN.secondary)
            }
            .padding(.horizontal, 24)
            .padding(.top, 26)
            .padding(.bottom, 22)

            ScrollView {
                LazyVStack(alignment: .leading, spacing: 10) {
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
                                Button("Voltooid") { store.setStatus(item, status: .completed) }.tint(.black)
                            }
                            .swipeActions(edge: .trailing, allowsFullSwipe: true) {
                                Button("Weg", role: .destructive) { store.delete(item) }
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
        let sorted = store.items.sorted { $0.createdAt > $1.createdAt }
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
}
