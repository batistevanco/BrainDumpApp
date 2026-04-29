import SwiftUI

struct WelcomeOnboardingPage: View {
    var body: some View {
        VStack(spacing: 0) {
            Spacer()
            ZStack {
                Circle().fill(FN.line).frame(width: 8, height: 8).offset(x: -110, y: -84)
                Circle().fill(FN.line).frame(width: 5, height: 5).offset(x: 86, y: -28)
                Circle().fill(FN.line).frame(width: 6, height: 6).offset(x: -74, y: 92)

                VStack(alignment: .leading, spacing: 0) {
                    Text("App-idee voor buurtmarkt")
                        .foregroundStyle(FN.secondary)
                        .font(.system(size: 15))
                        .padding(16)
                        .frame(maxWidth: .infinity, alignment: .leading)
                        .background(FN.surface)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .rotationEffect(.degrees(-2))
                        .opacity(0.6)
                        .padding(.horizontal, 28)
                        .offset(y: 26)

                    VStack(alignment: .leading, spacing: 8) {
                        Text("Mail beantwoorden van\nPieter")
                            .font(.system(size: 18, weight: .medium))
                            .foregroundStyle(FN.ink)
                        Text("14:23")
                            .font(.system(size: 15))
                            .foregroundStyle(FN.secondary)
                    }
                    .padding(.horizontal, 22)
                    .padding(.vertical, 20)
                    .frame(maxWidth: .infinity, alignment: .leading)
                    .background(Color.white)
                    .clipShape(RoundedRectangle(cornerRadius: 18))
                    .overlay(RoundedRectangle(cornerRadius: 18).stroke(FN.ink, lineWidth: 1.5))
                    .padding(.horizontal, 38)
                    .zIndex(2)

                    Text("Boodschappen: melk, brood")
                        .foregroundStyle(FN.tertiary)
                        .font(.system(size: 16, weight: .medium))
                        .padding(.horizontal, 24)
                        .padding(.vertical, 14)
                        .frame(maxWidth: .infinity, alignment: .center)
                        .background(FN.surface)
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                        .rotationEffect(.degrees(2))
                        .opacity(0.65)
                        .padding(.horizontal, 60)
                        .offset(y: -8)
                }
            }
            .frame(height: 270)

            Spacer()
            MascotIcon(size: 88)
                .padding(.bottom, 24)
            Text("Welkom bij\nBrainox")
                .font(.system(size: 36, weight: .medium))
                .multilineTextAlignment(.center)
                .foregroundStyle(FN.ink)
                .lineSpacing(2)
                .padding(.bottom, 16)
            Text("Leg gedachten, taken en ideeën\nvast zodra ze in je hoofd komen.")
                .font(.system(size: 21))
                .foregroundStyle(FN.secondary)
                .multilineTextAlignment(.center)
                .lineSpacing(6)
                .padding(.horizontal, 28)
            Spacer()
        }
    }
}
