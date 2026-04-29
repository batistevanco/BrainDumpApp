import SwiftUI

struct HeaderDateTitle<Trailing: View>: View {
    let date: Date
    let title: String
    @ViewBuilder var trailing: () -> Trailing

    var body: some View {
        HStack(alignment: .top) {
            VStack(alignment: .leading, spacing: 8) {
                Text(date.formatted(.dateTime.weekday(.wide).day().month(.wide).locale(Locale(identifier: "nl_BE"))).capitalized)
                    .font(.system(size: 18, weight: .medium))
                    .foregroundStyle(FN.secondary)
                Text(title)
                    .font(.system(size: 30, weight: .medium))
                    .foregroundStyle(FN.ink)
            }
            Spacer()
            trailing()
        }
        .padding(.horizontal, 18)
        .padding(.top, 16)
    }
}
