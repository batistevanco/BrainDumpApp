import SwiftUI

struct SearchView: View {
    @EnvironmentObject private var store: BrainDumpStore
    @State private var query = ""
    @State private var detailItem: FlowItem?
    @FocusState private var focused: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 0) {
            HStack(spacing: 10) {
                Image(systemName: "magnifyingglass")
                    .foregroundStyle(FN.tertiary)
                TextField("Zoek in je gedachten", text: $query)
                    .focused($focused)
                    .appFont(size: 18)
                    .textInputAutocapitalization(.never)
            }
            .padding(.horizontal, 18)
            .frame(height: 56)
            .background(FN.surface)
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .padding(.horizontal, 20)
            .padding(.top, 8)

            ScrollView {
                LazyVStack(spacing: 10) {
                    ForEach(results) { item in
                        Button {
                            focused = false
                            detailItem = item
                        } label: {
                            ItemCard(item: item)
                        }
                        .buttonStyle(.plain)
                    }
                }
                .padding(20)
            }
            .scrollDismissesKeyboard(.interactively)
            .simultaneousGesture(
                DragGesture(minimumDistance: 12)
                    .onChanged { _ in
                        focused = false
                    }
            )
        }
        .ignoresSafeArea(.keyboard, edges: .bottom)
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
