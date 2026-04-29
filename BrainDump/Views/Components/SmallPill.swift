import SwiftUI

struct SmallPill: View {
    let title: String

    init(_ title: String) {
        self.title = title
    }

    var body: some View {
        Text(title)
            .appFont(size: 14)
            .foregroundStyle(FN.secondary)
            .padding(.horizontal, 13)
            .padding(.vertical, 8)
            .background(FN.surface)
            .clipShape(RoundedRectangle(cornerRadius: 9))
    }
}
