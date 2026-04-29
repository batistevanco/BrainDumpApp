import SwiftUI

struct TimeOption: View {
    @EnvironmentObject private var store: BrainDumpStore
    let hour: Int
    let minute: Int
    let hint: String?

    private var selected: Bool {
        store.reviewHour == hour && store.reviewMinute == minute
    }

    var body: some View {
        Button {
            store.reviewHour = hour
            store.reviewMinute = minute
        } label: {
            HStack {
                Text(String(format: "%02d:%02d", hour, minute))
                    .font(.system(size: 23, weight: selected ? .medium : .regular))
                Spacer()
                if let hint {
                    Text(hint)
                        .font(.system(size: 17, weight: .medium))
                        .foregroundStyle(FN.tertiary)
                }
                if selected {
                    Image(systemName: "checkmark.circle.fill")
                        .font(.system(size: 22))
                }
            }
            .foregroundStyle(FN.ink)
            .padding(.horizontal, 24)
            .frame(height: 72)
            .background(selected ? FN.card : FN.surface)
            .clipShape(RoundedRectangle(cornerRadius: 18))
            .overlay(RoundedRectangle(cornerRadius: 18).stroke(selected ? FN.ink : Color.clear, lineWidth: 2))
        }
        .buttonStyle(.plain)
    }
}
