import SwiftUI

struct EmptyState: View {
    let title: String
    let text: String

    var body: some View {
        VStack(spacing: 8) {
            Text(title)
                .font(.system(size: 24, weight: .medium))
                .foregroundStyle(FN.ink)
            Text(text)
                .font(.system(size: 18))
                .foregroundStyle(FN.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(28)
        .background(FN.surface)
        .clipShape(RoundedRectangle(cornerRadius: 20))
    }
}
