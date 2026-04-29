import SwiftUI

struct ItemCard: View {
    let item: FlowItem

    var body: some View {
        VStack(alignment: .leading, spacing: 8) {
            Text(item.text)
                .font(.system(size: 23))
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
            .font(.system(size: 17))
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 20)
        .padding(.vertical, 18)
        .background(FN.surface)
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .opacity(item.status == .completed ? 0.55 : 1)
    }
}
