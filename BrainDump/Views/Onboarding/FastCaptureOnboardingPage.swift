import SwiftUI

struct FastCaptureOnboardingPage: View {
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            VStack(spacing: 18) {
                Text("WAT ZIT ER IN JE HOOFD?")
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(FN.tertiary)
                    .tracking(0.5)
                Text("Mail sturen naar klant|")
                    .font(.system(size: 30))
                    .foregroundStyle(FN.ink)
                    .frame(maxWidth: .infinity, minHeight: 128, alignment: .topLeading)
                    .padding(22)
                    .background(FN.surface)
                    .clipShape(RoundedRectangle(cornerRadius: 22))
                    .overlay(RoundedRectangle(cornerRadius: 22).stroke(FN.ink, lineWidth: 2))
                HStack(spacing: 8) {
                    Image(systemName: "checkmark.circle")
                    Text("Klaar in 2 seconden")
                }
                .font(.system(size: 20, weight: .medium))
                .foregroundStyle(FN.success)
            }
            .padding(.horizontal, 30)

            Spacer()
            Text("Binnen enkele\nseconden\nopgeslagen")
                .font(.system(size: 38, weight: .medium))
                .multilineTextAlignment(.center)
                .lineSpacing(3)
                .foregroundStyle(FN.ink)
                .padding(.bottom, 18)
            Text("Open de app, typ wat in je hoofd\nzit en sla het direct op. Geen\nmappen, geen afleiding.")
                .font(.system(size: 23))
                .foregroundStyle(FN.secondary)
                .multilineTextAlignment(.center)
                .lineSpacing(7)
                .padding(.horizontal, 24)
            Spacer()
        }
    }
}
