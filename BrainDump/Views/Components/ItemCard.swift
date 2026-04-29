import SwiftUI

struct ItemCard: View {
    let item: FlowItem

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            if let type = item.type {
                HStack(spacing: 5) {
                    Image(systemName: type.icon)
                    Text(type.label)
                }
                .appFont(size: 12, weight: .medium)
                .foregroundStyle(type.color)
                .padding(.horizontal, 9)
                .padding(.vertical, 4)
                .background(type.color.opacity(0.1))
                .clipShape(RoundedRectangle(cornerRadius: 7))
            }
            Text(item.text)
                .appFont(size: 20)
                .foregroundStyle(FN.ink)
                .strikethrough(item.status == .completed)
                .lineLimit(3)
                .multilineTextAlignment(.leading)
            HStack(spacing: 6) {
                Text(time(item.createdAt))
                    .foregroundStyle(FN.secondary)
                Text("·")
                    .foregroundStyle(FN.tertiary)
                Image(systemName: item.status.icon)
                    .foregroundStyle(item.status.color)
                Text(item.status.label)
                    .foregroundStyle(item.status.color)
            }
            .appFont(size: 15)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 17)
        .padding(.vertical, 15)
        .background(FN.surface)
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .opacity(item.status == .completed ? 0.55 : 1)
    }
}
