import SwiftUI

struct SearchView: View {
    @EnvironmentObject private var store: BrainDumpStore
    @State private var query = ""
    @State private var detailItem: FlowItem?
    @FocusState private var focused: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            Text("Zoek")
                .font(.system(size: 36, weight: .medium))
                .foregroundStyle(FN.ink)
                .padding(.horizontal, 24)
                .padding(.top, 28)
            HStack(spacing: 10) {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(FN.tertiary)
                TextField("Zoek in je gedachten", text: $query)
                    .focused($focused)
                    .font(.system(size: 20))
                    .textInputAutocapitalization(.never)
            }
            .padding(.horizontal, 18)
            .frame(height: 62)
            .background(FN.surface)
            .clipShape(RoundedRectangle(cornerRadius: 18))
            .padding(.horizontal, 20)
            .padding(.top, 22)

            ScrollView {
                LazyVStack(spacing: 10) {
                    ForEach(results) { item in
                        Button { detailItem = item } label: {
                            ItemCard(item: item)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(20)
            }
        }
        .onAppear { focused = true }
        .sheet(item: $detailItem) { item in
            ItemDetailView(item: item)
        }
    }

    private var results: [FlowItem] {
        let clean = query.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !clean.isEmpty else { return store.items.sorted { $0.createdAt > $1.createdAt } }
        return store.items.filter { $0.text.localizedCaseInsensitiveContains(clean) }.sorted { $0.createdAt > $1.createdAt }
    }
}
