import SwiftUI

struct ActiveReviewCard: View {
    @EnvironmentObject private var store: BrainDumpStore
    let item: FlowItem

    var body: some View {
        VStack(alignment: .leading, spacing: 14) {
            Text("VANDAAG · \(time(item.createdAt))")
                .font(.system(size: 17, weight: .medium))
                .foregroundStyle(FN.ink)
            Text(item.text)
                .font(.system(size: 24))
                .foregroundStyle(FN.ink)
                .lineSpacing(4)
            HStack(spacing: 8) {
                ReviewActionButton(title: "✓ Klaar", primary: true) {
                    withAnimation(.easeInOut(duration: 0.25)) { store.setStatus(item, status: .completed) }
                }
                ReviewActionButton(title: "Bewaar") {
                    withAnimation(.easeInOut(duration: 0.25)) { store.setStatus(item, status: .saved) }
                }
                ReviewActionButton(title: "Weg", destructive: true) {
                    withAnimation(.easeInOut(duration: 0.25)) { store.delete(item) }
                }
            }
        }
        .frame(maxWidth: .infinity, alignment: .leading)
        .padding(24)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 22))
        .overlay(RoundedRectangle(cornerRadius: 22).stroke(FN.ink, lineWidth: 2))
    }
}
