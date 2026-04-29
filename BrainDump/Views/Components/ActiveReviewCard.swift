import SwiftUI
import UIKit

struct ActiveReviewCard: View {
    @EnvironmentObject private var store: BrainDumpStore
    let item: FlowItem

    var body: some View {
        VStack(alignment: .leading, spacing: 12) {
            HStack {
                Text("VANDAAG · \(time(item.createdAt))")
                    .appFont(size: 15, weight: .medium)
                    .foregroundStyle(FN.ink)
                Spacer()
                if let type = item.type {
                    HStack(spacing: 5) {
                        Image(systemName: type.icon)
                        Text(type.label)
                    }
                    .appFont(size: 12, weight: .medium)
                    .foregroundStyle(type.color)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 4)
                    .background(type.color.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }
            Text(item.text)
                .appFont(size: 21)
                .foregroundStyle(FN.ink)
                .lineSpacing(4)
            HStack(spacing: 8) {
                ReviewActionButton(title: "Klaar", icon: "checkmark.circle.fill", accentColor: FlowItemStatus.completed.color) {
                    UIImpactFeedbackGenerator(style: .medium).impactOccurred()
                    withAnimation(.spring(response: 0.38, dampingFraction: 0.82)) { store.setStatus(item, status: .completed) }
                }
                ReviewActionButton(title: "Bewaar", icon: "bookmark.fill", accentColor: FlowItemStatus.saved.color) {
                    UIImpactFeedbackGenerator(style: .light).impactOccurred()
                    withAnimation(.spring(response: 0.38, dampingFraction: 0.82)) { store.setStatus(item, status: .saved) }
                }
                ReviewActionButton(title: "Verwijder", destructive: true) {
                    UINotificationFeedbackGenerator().notificationOccurred(.warning)
                    withAnimation(.spring(response: 0.38, dampingFraction: 0.82)) { store.delete(item) }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(20)
        .background(FN.card)
        .clipShape(RoundedRectangle(cornerRadius: 19))
        .overlay(RoundedRectangle(cornerRadius: 19).stroke(FN.ink, lineWidth: 2))
    }
}
