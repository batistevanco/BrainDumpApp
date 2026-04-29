import SwiftUI

struct ReviewActionButton: View {
    let title: String
    var primary = false
    var destructive = false
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            Text(title)
                .font(.system(size: 18, weight: .medium))
                .foregroundStyle(primary ? Color.white : destructive ? FN.secondary : FN.ink)
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(primary ? FN.ink : FN.surface)
                .clipShape(RoundedRectangle(cornerRadius: 14))
        }
        .buttonStyle(.plain)
    }
}
