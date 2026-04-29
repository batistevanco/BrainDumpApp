import SwiftUI
import UIKit

struct ActiveReviewCard: View {
    @EnvironmentObject private var store: BrainDumpStore
    let item: FlowItem

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            HStack {
                Text("VANDAAG · \(time(item.createdAt))")
                    .font(.system(size: 17, weight: .medium))
                    .foregroundStyle(FN.ink)
                Spacer()
                if let type = item.type {
                    HStack(spacing: 5) {
                        Image(systemName: type.icon)
                        Text(type.label)
                    }
                    .font(.system(size: 13, weight: .medium))
                    .foregroundStyle(type.color)
                    .padding(.horizontal, 10)
                    .padding(.vertical, 5)
                    .background(type.color.opacity(0.1))
                    .clipShape(RoundedRectangle(cornerRadius: 8))
                }
            }
            Text(item.text)
                .font(.system(size: 24))
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
                ReviewActionButton(title: "Weg", destructive: true) {
                    UINotificationFeedbackGenerator().notificationOccurred(.warning)
                    withAnimation(.spring(response: 0.38, dampingFraction: 0.82)) { store.delete(item) }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(24)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 22))
        .overlay(RoundedRectangle(cornerRadius: 22).stroke(FN.ink, lineWidth: 2))
    }
}
