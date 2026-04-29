import SwiftUI

struct PrimaryButton: View {
    let title: String
    var disabled = false
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 24, weight: .medium))
                .foregroundStyle(Color.white)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 21)
                .background(disabled ? FN.ink.opacity(0.35) : FN.ink)
                .clipShape(RoundedRectangle(cornerRadius: 22))
        }
        .disabled(disabled)
        .buttonStyle(.plain)
    }
}
