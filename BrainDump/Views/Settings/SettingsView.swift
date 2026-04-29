import SwiftUI

struct SettingsView: View {
    @EnvironmentObject private var store: BrainDumpStore
    @Environment(\.dismiss) private var dismiss
    @State private var exporting = false
    @State private var importing = false
    @State private var importError = false
    @State private var notificationAlertTitle = ""
    @State private var notificationAlertMessage = ""
    @State private var showingNotificationAlert = false

    var body: some View {
        NavigationStack {
            ZStack {
                FN.surface.ignoresSafeArea()

                ScrollView(showsIndicators: false) {
                    VStack(alignment: .leading, spacing: 26) {
                        header
                        appCard
                        captureCard
                        reviewCard
                        backupCard
                        onboardingCard
                    }
                    .padding(.horizontal, 22)
                    .padding(.top, 20)
                    .padding(.bottom, 36)
                }
            }
            .navigationBarTitleDisplayMode(.inline)
            .toolbar(.hidden, for: .navigationBar)
            .fileExporter(isPresented: $exporting, document: BrainDumpBackupDocument(backup: store.backup), contentType: .brainDumpBackup, defaultFilename: "BrainDump-backup.braindump") { _ in }
            .fileImporter(isPresented: $importing, allowedContentTypes: [.brainDumpBackup, .json]) { result in
                do {
                    let url = try result.get()
                    guard url.startAccessingSecurityScopedResource() else { return }
                    defer { url.stopAccessingSecurityScopedResource() }
                    let data = try Data(contentsOf: url)
                    let backup = try BrainDumpStore.decoder.decode(BrainDumpBackup.self, from: data)
                    store.importBackup(BrainDumpBackupDocument(backup: backup))
                } catch {
                    importError = true
                }
            }
            .alert("Importeren mislukt", isPresented: $importError) {
                Button("Ok", role: .cancel) {}
            } message: {
                Text("Controleer of het bestand een BrainDump JSON-backup is.")
            }
            .alert(notificationAlertTitle, isPresented: $showingNotificationAlert) {
                Button("Ok", role: .cancel) {}
            } message: {
                Text(notificationAlertMessage)
            }
        }
    }

    private var header: some View {
        HStack {
            Button {
                dismiss()
            } label: {
                Text("Klaar")
                    .font(.system(size: 18, weight: .medium))
                    .foregroundStyle(FN.ink)
                    .padding(.horizontal, 22)
                    .padding(.vertical, 14)
                    .background(Color.white)
                    .clipShape(Capsule())
                    .shadow(color: FN.ink.opacity(0.06), radius: 18, y: 8)
            }
            .buttonStyle(.plain)

            Spacer()

            Text("Instellingen")
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(FN.ink)

            Spacer()

            Color.clear
                .frame(width: 91, height: 50)
        }
    }

    private var appCard: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack(alignment: .center, spacing: 16) {
                MascotIcon(size: 76)

                VStack(alignment: .leading, spacing: 6) {
                    Text("BrainDump")
                        .font(.system(size: 28, weight: .semibold))
                        .foregroundStyle(FN.ink)
                    Text("Je mentale inbox, lokaal op je iPhone.")
                        .font(.system(size: 17, weight: .medium))
                        .foregroundStyle(FN.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }
            }

            HStack(spacing: 10) {
                SettingsStatPill(value: "\(store.todayItems.count)", label: "vandaag")
                SettingsStatPill(value: "\(store.reviewQueue.count)", label: "review")
                SettingsStatPill(value: "\(store.items.count)", label: "totaal")
            }
        }
        .padding(22)
        .background(Color.white)
        .clipShape(RoundedRectangle(cornerRadius: 28))
        .shadow(color: FN.ink.opacity(0.05), radius: 22, y: 12)
    }

    private var captureCard: some View {
        SettingsGroup(title: "Capture") {
            SettingsToggleRow(
                icon: "mic.fill",
                title: "Dicteren",
                subtitle: "Toon de microfoonknop op het capture-scherm",
                isOn: $store.isDictationEnabled
            )
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 28))
        }
    }

    private var reviewCard: some View {
        SettingsGroup(title: "Daily Review") {
            VStack(spacing: 0) {
                HStack(spacing: 14) {
                    SettingsIcon(name: "clock")

                    VStack(alignment: .leading, spacing: 3) {
                        Text("Reviewmoment")
                            .font(.system(size: 19, weight: .semibold))
                            .foregroundStyle(FN.ink)
                        Text("Elke dag om \(reviewTimeText)")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundStyle(FN.secondary)
                    }

                    Spacer()

                    DatePicker("", selection: reviewBinding, displayedComponents: .hourAndMinute)
                        .labelsHidden()
                        .tint(FN.ink)
                }
                .padding(18)

                Divider()
                    .padding(.leading, 70)

                SettingsActionRow(icon: "bell.badge", title: "Reminder opnieuw plannen", subtitle: "Zet de dagelijkse review opnieuw klaar in iOS") {
                    store.scheduleReviewNotification { success in
                        notificationAlertTitle = success ? "Reminder gepland" : "Notificatie niet toegestaan"
                        notificationAlertMessage = success
                            ? "BrainDump herinnert je elke dag om \(reviewTimeText) aan je Daily Review."
                            : "Sta notificaties toe in iOS-instellingen om Daily Review reminders te ontvangen."
                        showingNotificationAlert = true
                    }
                }
            }
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 28))
        }
    }

    private var backupCard: some View {
        SettingsGroup(title: "Backup") {
            VStack(spacing: 0) {
                SettingsActionRow(icon: "square.and.arrow.up", title: "Exporteer data", subtitle: "Maak een BrainDump-backup voor een ander toestel") {
                    exporting = true
                }

                Divider()
                    .padding(.leading, 70)

                SettingsActionRow(icon: "square.and.arrow.down", title: "Importeer data", subtitle: "Zet een eerdere backup terug op deze iPhone") {
                    importing = true
                }
            }
            .background(Color.white)
            .clipShape(RoundedRectangle(cornerRadius: 28))
        }
    }

    private var onboardingCard: some View {
        SettingsGroup(title: "Onboarding") {
            Button {
                store.hasCompletedOnboarding = false
                dismiss()
            } label: {
                HStack(spacing: 14) {
                    SettingsIcon(name: "sparkles")

                    VStack(alignment: .leading, spacing: 3) {
                        Text("Toon onboarding opnieuw")
                            .font(.system(size: 18, weight: .semibold))
                            .foregroundStyle(FN.ink)
                        Text("Bekijk de eerste uitlegschermen nog eens")
                            .font(.system(size: 14, weight: .medium))
                            .foregroundStyle(FN.secondary)
                    }

                    Spacer()

                    Image(systemName: "chevron.right")
                        .font(.system(size: 15, weight: .bold))
                        .foregroundStyle(FN.tertiary)
                }
                .padding(18)
                .background(Color.white)
                .clipShape(RoundedRectangle(cornerRadius: 28))
            }
            .buttonStyle(.plain)
        }
    }

    private var reviewTimeText: String {
        String(format: "%02d:%02d", store.reviewHour, store.reviewMinute)
    }

    private var reviewBinding: Binding<Date> {
        Binding {
            var components = DateComponents()
            components.hour = store.reviewHour
            components.minute = store.reviewMinute
            return Calendar.current.date(from: components) ?? Date()
        } set: { newValue in
            let parts = Calendar.current.dateComponents([.hour, .minute], from: newValue)
            store.reviewHour = parts.hour ?? 20
            store.reviewMinute = parts.minute ?? 0
            store.scheduleReviewNotification()
        }
    }
}

private struct SettingsGroup<Content: View>: View {
    let title: String
    @ViewBuilder let content: Content

    var body: some View {
        VStack(alignment: .leading, spacing: 10) {
            Text(title)
                .font(.system(size: 21, weight: .semibold))
                .foregroundStyle(FN.tertiary)
                .padding(.leading, 22)

            content
                .shadow(color: FN.ink.opacity(0.035), radius: 18, y: 10)
        }
    }
}

private struct SettingsStatPill: View {
    let value: String
    let label: String

    var body: some View {
        VStack(spacing: 2) {
            Text(value)
                .font(.system(size: 20, weight: .semibold))
                .foregroundStyle(FN.ink)
            Text(label)
                .font(.system(size: 12, weight: .semibold))
                .foregroundStyle(FN.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 12)
        .background(FN.surface)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

private struct SettingsActionRow: View {
    let icon: String
    let title: String
    let subtitle: String
    let action: () -> Void

    var body: some View {
        Button(action: action) {
            HStack(spacing: 14) {
                SettingsIcon(name: icon)

                VStack(alignment: .leading, spacing: 3) {
                    Text(title)
                        .font(.system(size: 18, weight: .semibold))
                        .foregroundStyle(FN.ink)
                    Text(subtitle)
                        .font(.system(size: 14, weight: .medium))
                        .foregroundStyle(FN.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .font(.system(size: 15, weight: .bold))
                    .foregroundStyle(FN.tertiary)
            }
            .padding(18)
            .contentShape(Rectangle())
        }
        .buttonStyle(.plain)
    }
}

private struct SettingsToggleRow: View {
    let icon: String
    let title: String
    let subtitle: String
    @Binding var isOn: Bool

    var body: some View {
        HStack(spacing: 14) {
            SettingsIcon(name: icon)

            VStack(alignment: .leading, spacing: 3) {
                Text(title)
                    .font(.system(size: 18, weight: .semibold))
                    .foregroundStyle(FN.ink)
                Text(subtitle)
                    .font(.system(size: 14, weight: .medium))
                    .foregroundStyle(FN.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Spacer()

            Toggle("", isOn: $isOn)
                .labelsHidden()
                .tint(FN.ink)
        }
        .padding(18)
    }
}

private struct SettingsIcon: View {
    let name: String

    var body: some View {
        Image(systemName: name)
            .font(.system(size: 18, weight: .semibold))
            .foregroundStyle(FN.ink)
            .frame(width: 38, height: 38)
            .background(FN.surface)
            .clipShape(RoundedRectangle(cornerRadius: 13))
    }
}
