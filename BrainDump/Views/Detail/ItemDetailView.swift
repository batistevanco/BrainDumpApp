import SwiftUI
import UIKit

struct ItemDetailView: View {
    @EnvironmentObject private var store: BrainDumpStore
    @Environment(\.dismiss) private var dismiss
    let item: FlowItem
    @State private var editedText: String

    init(item: FlowItem) {
        self.item = item
        _editedText = State(initialValue: item.text)
    }

    var body: some View {
        NavigationStack {
            VStack(spacing: 18) {
                TextEditor(text: $editedText)
                    .font(.system(size: 24))
                    .scrollContentBackground(.hidden)
                    .padding(18)
                    .background(FN.surface)
                    .clipShape(RoundedRectangle(cornerRadius: 20))
                    .frame(minHeight: 260)
                Text(item.createdAt.formatted(.dateTime.weekday(.wide).day().month(.wide).hour().minute().locale(Locale(identifier: "nl_BE"))))
                    .font(.system(size: 17))
                    .foregroundStyle(FN.secondary)
                    .frame(maxWidth: .infinity, alignment: .leading)
                HStack(spacing: 10) {
                    ReviewActionButton(title: "Klaar", icon: "checkmark.circle.fill", accentColor: FlowItemStatus.completed.color) {
                        UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                        store.updateItem(item, text: editedText)
                        store.setStatus(item, status: .completed)
                        dismiss()
                    }
                    ReviewActionButton(title: "Bewaar", icon: "bookmark.fill", accentColor: FlowItemStatus.saved.color) {
                        UIImpactFeedbackGenerator(style: .light).impactOccurred()
                        store.updateItem(item, text: editedText)
                        store.setStatus(item, status: .saved)
                        dismiss()
                    }
                    ReviewActionButton(title: "Weg", destructive: true) {
                        UINotificationFeedbackGenerator().notificationOccurred(.warning)
                        store.delete(item)
                        dismiss()
                    }
                }
                Spacer()
            }
            .padding(20)
            .navigationTitle("Detail")
            .navigationBarTitleDisplayMode(.inline)
            .toolbar {
                ToolbarItem(placement: .cancellationAction) {
                    Button("Terug") { dismiss() }
                }
                ToolbarItem(placement: .confirmationAction) {
                    Button("Bewaar") {
                        store.updateItem(item, text: editedText)
                        dismiss()
                    }
                }
            }
        }
    }
}
