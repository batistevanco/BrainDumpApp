import SwiftUI

struct EmptyState: View {
    let title: String
    let text: String

    var body: some View {
        VStack(spacing: 8) {
            Text(title)
                .appFont(size: 21, weight: .medium)
                .foregroundStyle(FN.ink)
            Text(text)
                .appFont(size: 16)
                .foregroundStyle(FN.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(24)
        .background(FN.surface)
        .clipShape(RoundedRectangle(cornerRadius: 17))
    }
}
