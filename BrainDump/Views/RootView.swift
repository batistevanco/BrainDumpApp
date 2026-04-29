import SwiftUI

struct RootView: View {
    @EnvironmentObject private var store: BrainDumpStore

    var body: some View {
        Group {
            if store.hasCompletedOnboarding {
                MainShellView()
            } else {
                OnboardingView()
            }
        }
        .background(Color.white)
    }
}
