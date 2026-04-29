import SwiftUI

struct SectionLabel: View {
    let title: String

    init(_ title: String) {
        self.title = title
    }

    var body: some View {
        Text(title.uppercased())
            .font(.system(size: 17, weight: .medium))
            .foregroundStyle(FN.tertiary)
            .tracking(0.5)
            .frame(maxWidth: .infinity, alignment: .leading)
    }
}
