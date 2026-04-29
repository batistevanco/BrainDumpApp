import SwiftUI

struct PrimaryButton: View {
    let title: String
    var disabled = false
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .appFont(size: 21, weight: .medium)
                .foregroundStyle(disabled ? FN.secondary : FN.surface)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 17)
                .background(disabled ? FN.line : FN.ink)
                .clipShape(RoundedRectangle(cornerRadius: 19))
        }
        .disabled(disabled)
        .buttonStyle(.plain)
    }
}
