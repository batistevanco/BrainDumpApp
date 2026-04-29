import SwiftUI

struct NotificationOnboardingPage: View {
    @EnvironmentObject private var store: BrainDumpStore
    @Binding var showingTimePicker: Bool

    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            Image(systemName: "clock")
                .font(.system(size: 36, weight: .regular))
                .foregroundStyle(FN.ink)
                .frame(width: 76, height: 76)
                .background(FN.surface)
                .clipShape(RoundedRectangle(cornerRadius: 24))
                .padding(.bottom, 34)
            Text("Wanneer wil je je\nreview doen?")
                .font(.system(size: 39, weight: .medium))
                .multilineTextAlignment(.center)
                .lineSpacing(3)
                .foregroundStyle(FN.ink)
                .padding(.bottom, 22)
            Text("Kies een vast moment waarop\nBrainDump je eraan herinnert.")
                .font(.system(size: 23))
                .foregroundStyle(FN.secondary)
                .multilineTextAlignment(.center)
                .lineSpacing(7)
                .padding(.bottom, 42)

            VStack(spacing: 12) {
                TimeOption(hour: 18, minute: 0, hint: "na het werk")
                TimeOption(hour: 20, minute: 0, hint: nil)
                TimeOption(hour: 21, minute: 30, hint: "voor het slapen")
                Button { showingTimePicker = true } label: {
                    HStack {
                        Text("Zelf kiezen")
                        Spacer()
                        Text("›").foregroundStyle(FN.secondary)
                    }
                    .font(.system(size: 23, weight: .medium))
                    .foregroundStyle(FN.ink)
                    .padding(.horizontal, 24)
                    .frame(height: 72)
                    .background(FN.surface)
                    .clipShape(RoundedRectangle(cornerRadius: 18))
                }
                Button("Overslaan") {
                    store.hasCompletedOnboarding = true
                }
                .font(.system(size: 22, weight: .medium))
                .foregroundStyle(FN.tertiary)
                .padding(.top, 8)
            }
            .padding(.horizontal, 30)
            Spacer()
        }
    }
}
