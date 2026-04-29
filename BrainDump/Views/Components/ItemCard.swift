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
            Text("\(time(item.createdAt)) · \(item.status.label)")
                .font(.system(size: 17))
                .foregroundStyle(FN.secondary)
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(.horizontal, 20)
        .padding(.vertical, 18)
        .background(FN.surface)
        .clipShape(RoundedRectangle(cornerRadius: 18))
        .opacity(item.status == .completed ? 0.55 : 1)
    }
}
