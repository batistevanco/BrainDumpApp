import SwiftUI

struct ReviewOnboardingPage: View {
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            VStack(alignment: .leading, spacing: 12) {
                Text("VANDAAG · 3 ITEMS")
                    .font(.system(size: 18, weight: .medium))
                    .tracking(0.5)
                MiniReviewRow(icon: "checkmark.circle.fill", text: "Melk kopen", completed: true)
                MiniReviewRow(icon: "bookmark", text: "Idee: buurthulp app", completed: false)
                HStack(spacing: 14) {
                    Circle().stroke(FN.ink, style: StrokeStyle(lineWidth: 2, dash: [2, 4])).frame(width: 24, height: 24)
                    Text("Mail Pieter beantwoorden").font(.system(size: 22, weight: .medium))
                }
                .padding(18)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 18))
                .overlay(RoundedRectangle(cornerRadius: 18).stroke(FN.ink, lineWidth: 2))
                HStack(spacing: 8) {
                    SmallPill("Klaar")
                    SmallPill("Bewaar")
                    SmallPill("Weg")
                }
                .frame(maxWidth: .infinity)
            }
            .padding(.horizontal, 30)

            Spacer()
            Text("Verwerk je\ngedachten elke\navond")
                .font(.system(size: 37, weight: .medium))
                .multilineTextAlignment(.center)
                .lineSpacing(3)
                .foregroundStyle(FN.ink)
                .padding(.bottom, 18)
            Text("Beslis kort wat klaar is, wat\nbewaard moet worden en wat\nweg mag.")
                .font(.system(size: 23))
                .foregroundStyle(FN.secondary)
                .multilineTextAlignment(.center)
                .lineSpacing(7)
                .padding(.horizontal, 24)
            Spacer()
        }
    }
}
