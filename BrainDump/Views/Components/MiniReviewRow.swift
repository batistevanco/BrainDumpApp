import SwiftUI

struct MiniReviewRow: View {
    let icon: String
    let text: String
    let completed: Bool

    var body: some View {
        HStack(spacing: 14) {
            Image(systemName: icon)
                .font(.system(size: 22, weight: .medium))
                .foregroundStyle(FN.ink)
            Text(text)
                .font(.system(size: 22, weight: .medium))
                .foregroundStyle(completed ? FN.secondary : FN.ink)
                .strikethrough(completed)
            Spacer()
        }
        .padding(.horizontal, 18)
        .frame(height: 64)
        .background(FN.surface)
        .clipShape(RoundedRectangle(cornerRadius: 18))
    }
}
