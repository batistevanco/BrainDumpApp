import SwiftUI

struct OnboardingView: View {
    @EnvironmentObject private var store: BrainDumpStore
    @State private var page = 0
    @State private var customDate = Date()
    @State private var showingTimePicker = false

    var body: some View {
        VStack(spacing: 0) {
            header
                .padding(.top, 12)

            TabView(selection: $page) {
                WelcomeOnboardingPage().tag(0)
                FastCaptureOnboardingPage().tag(1)
                ReviewOnboardingPage().tag(2)
                NotificationOnboardingPage(showingTimePicker: $showingTimePicker).tag(3)
            }
            .tabViewStyle(.page(indexDisplayMode: .never))

            ProgressDots(current: page, count: 4)
                .padding(.bottom, 18)

            PrimaryButton(title: page == 0 ? "Start" : page == 3 ? "Brainox gebruiken" : "Volgende") {
                if page < 3 {
                    withAnimation(.spring(response: 0.25, dampingFraction: 0.9)) { page += 1 }
                } else {
                    finish()
                }
            }
            .padding(.horizontal, 20)
            .padding(.bottom, 20)
        }
        .sheet(isPresented: $showingTimePicker) {
            NavigationStack {
                DatePicker("Reviewmoment", selection: $customDate, displayedComponents: .hourAndMinute)
                    .datePickerStyle(.wheel)
                    .labelsHidden()
                    .padding()
                    .navigationTitle("Zelf kiezen")
                    .navigationBarTitleDisplayMode(.inline)
                    .toolbar {
                        ToolbarItem(placement: .confirmationAction) {
                            Button("Klaar") {
                                let parts = Calendar.current.dateComponents([.hour, .minute], from: customDate)
                                store.reviewHour = parts.hour ?? 20
                                store.reviewMinute = parts.minute ?? 0
                                showingTimePicker = false
                            }
                        }
                    }
            }
            .presentationDetents([.height(260)])
        }
    }

    private var header: some View {
        HStack {
            if page > 0 {
                Button {
                    withAnimation(.spring(response: 0.25, dampingFraction: 0.9)) { page -= 1 }
                } label: {
                    Text("← Terug")
                        .font(.system(size: 18, weight: .medium))
                        .foregroundStyle(FN.secondary)
                }
            }
            Spacer()
            Button("Overslaan") { finish() }
                .font(.system(size: 18, weight: .medium))
                .foregroundStyle(FN.tertiary)
                .opacity(page == 3 ? 0 : 1)
        }
        .padding(.horizontal, 24)
        .frame(height: 44)
    }

    private func finish() {
        store.hasCompletedOnboarding = true
        store.scheduleReviewNotification()
    }
}
