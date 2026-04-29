import SwiftUI

struct CustomTabBar: View {
    @Binding var selected: FlowTab

    var body: some View {
        HStack {
            ForEach(FlowTab.allCases, id: \.self) { tab in
                Button { selected = tab } label: {
                    VStack(spacing: 4) {
                        Image(systemName: tab.icon)
                            .font(.system(size: 22, weight: .regular))
                        Text(tab.rawValue)
                            .font(.system(size: 12, weight: selected == tab ? .medium : .regular))
                    }
                    .foregroundStyle(selected == tab ? FN.ink : FN.tertiary)
                    .frame(maxWidth: .infinity)
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.top, 8)
        .padding(.bottom, 10)
        .background(FN.card)
        .overlay(Rectangle().fill(FN.line).frame(height: 0.5), alignment: .top)
    }
}
