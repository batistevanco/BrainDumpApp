import SwiftUI

struct ReviewActionButton: View {
    let title: String
    var icon: String? = nil
    var accentColor: Color? = nil
    var destructive = false
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 6) {
                if let icon {
                    Image(systemName: icon)
                }
                Text(title)
            }
            .font(.system(size: 18, weight: .medium))
            .foregroundStyle(labelColor)
            .frame(maxWidth: .infinity)
            .padding(.vertical, 16)
            .background(backgroundColor)
            .clipShape(RoundedRectangle(cornerRadius: 14))
        }
        .buttonStyle(.plain)
    }

    private var backgroundColor: Color {
        if let accentColor { return accentColor.opacity(0.12) }
        return FN.surface
    }

    private var labelColor: Color {
        if destructive { return FN.secondary }
        if let accentColor { return accentColor }
        return FN.ink
    }
}
