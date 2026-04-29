import SwiftUI

struct SmallPill: View {
    let title: String

    init(_ title: String) {
        self.title = title
    }

    var body: some View {
        Text(title)
            .font(.system(size: 16))
            .foregroundStyle(FN.secondary)
            .padding(.horizontal, 16)
            .padding(.vertical, 10)
            .background(FN.surface)
            .clipShape(RoundedRectangle(cornerRadius: 10))
    }
}
