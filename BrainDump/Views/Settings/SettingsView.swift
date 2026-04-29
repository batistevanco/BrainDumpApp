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
                        appearanceCard
                        captureCard
                        reviewCard
                        backupCard
                        onboardingCard
                        supportCard
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
                    .appFont(size: 16, weight: .medium)
                    .foregroundStyle(FN.ink)
                    .padding(.horizontal, 22)
                    .padding(.vertical, 12)
                    .background(FN.card)
                    .clipShape(Capsule())
                    .shadow(color: FN.ink.opacity(0.06), radius: 18, y: 8)
            }
            .buttonStyle(.plain)

            Spacer()

            Text("Instellingen")
                .appFont(size: 16, weight: .semibold)
                .foregroundStyle(FN.ink)

            Spacer()

            Color.clear
                .frame(width: 91, height: 50)
        }
    }

    private var appCard: some View {
        VStack(alignment: .leading, spacing: 18) {
            HStack(alignment: .center, spacing: 16) {
                MascotIcon(size: 66)

                VStack(alignment: .leading, spacing: 6) {
                    Text("Brainox")
                        .appFont(size: 24, weight: .semibold)
                        .foregroundStyle(FN.ink)
                    Text("Hoofd leeg. Dag helder.")
                        .appFont(size: 15, weight: .medium)
                        .foregroundStyle(FN.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                    Text("Versie \(appVersion) · Build \(buildNumber)")
                        .appFont(size: 13, weight: .medium)
                        .foregroundStyle(FN.tertiary)
                }
            }

            HStack(spacing: 10) {
                SettingsStatPill(value: "\(store.todayItems.count)", label: "vandaag")
                SettingsStatPill(value: "\(store.reviewQueue.count)", label: "review")
                SettingsStatPill(value: "\(store.items.count)", label: "totaal")
            }
        }
        .padding(19)
        .background(FN.card)
        .clipShape(RoundedRectangle(cornerRadius: 24))
        .shadow(color: FN.ink.opacity(0.05), radius: 22, y: 12)
    }

    private var appearanceCard: some View {
        SettingsGroup(title: "Weergave") {
            VStack(spacing: 0) {
                VStack(alignment: .leading, spacing: 12) {
                    HStack(spacing: 14) {
                        SettingsIcon(name: "textformat.size")

                        VStack(alignment: .leading, spacing: 3) {
                            Text("Tekstgrootte")
                                .appFont(size: 16, weight: .semibold)
                                .foregroundStyle(FN.ink)
                            Text("Pas tekst en knoppen in de app aan")
                                .appFont(size: 13, weight: .medium)
                                .foregroundStyle(FN.secondary)
                                .fixedSize(horizontal: false, vertical: true)
                        }

                        Spacer()
                    }

                    Picker("Tekstgrootte", selection: textSizeBinding) {
                        ForEach(TextSizePreference.allCases) { option in
                            Text(option.label).tag(option)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                .padding(16)

                Divider()
                    .padding(.leading, 16)

                VStack(alignment: .leading, spacing: 12) {
                    HStack(spacing: 14) {
                        SettingsIcon(name: "circle.lefthalf.filled")

                        VStack(alignment: .leading, spacing: 3) {
                            Text("Weergavemodus")
                                .appFont(size: 16, weight: .semibold)
                                .foregroundStyle(FN.ink)
                            Text("Kies licht, donker of volg het systeem")
                                .appFont(size: 13, weight: .medium)
                                .foregroundStyle(FN.secondary)
                                .fixedSize(horizontal: false, vertical: true)
                        }

                        Spacer()
                    }

                    Picker("Weergavemodus", selection: colorSchemeBinding) {
                        ForEach(ColorSchemePreference.allCases) { option in
                            Text(option.label).tag(option)
                        }
                    }
                    .pickerStyle(.segmented)
                }
                .padding(16)
            }
            .background(FN.card)
            .clipShape(RoundedRectangle(cornerRadius: 24))
        }
    }

    private var captureCard: some View {
        SettingsGroup(title: "Capture") {
            VStack(spacing: 0) {
                SettingsToggleRow(
                    icon: "mic.fill",
                    title: "Dicteren",
                    subtitle: "Toon de microfoonknop op het capture-scherm",
                    isOn: $store.isDictationEnabled
                )

                Divider()
                    .padding(.leading, 70)

                SettingsToggleRow(
                    icon: "stop.circle.fill",
                    title: "Stop na verzenden",
                    subtitle: "Zet dictatie automatisch uit zodra je een item opslaat",
                    isOn: $store.stopDictationAfterSave
                )
                .disabled(!store.isDictationEnabled)
                .opacity(store.isDictationEnabled ? 1 : 0.45)
            }
            .background(FN.card)
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
                            .appFont(size: 17, weight: .semibold)
                            .foregroundStyle(FN.ink)
                        Text("Elke dag om \(reviewTimeText)")
                            .appFont(size: 13, weight: .medium)
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
                            ? "Brainox herinnert je elke dag om \(reviewTimeText) aan je Daily Review."
                            : "Sta notificaties toe in iOS-instellingen om Daily Review reminders te ontvangen."
                        showingNotificationAlert = true
                    }
                }
            }
            .background(FN.card)
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
            .background(FN.card)
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
                            .appFont(size: 16, weight: .semibold)
                            .foregroundStyle(FN.ink)
                        Text("Bekijk de eerste uitlegschermen nog eens")
                            .appFont(size: 13, weight: .medium)
                            .foregroundStyle(FN.secondary)
                    }

                    Spacer()

                    Image(systemName: "chevron.right")
                        .appFont(size: 14, weight: .bold)
                        .foregroundStyle(FN.tertiary)
                }
                .padding(18)
                .background(FN.card)
                .clipShape(RoundedRectangle(cornerRadius: 28))
            }
            .buttonStyle(.plain)
        }
    }

    private var supportCard: some View {
        SettingsGroup(title: "Support") {
            VStack(spacing: 0) {
                Link(destination: URL(string: "mailto:support@vancoilliestudio.be")!) {
                    HStack(spacing: 14) {
                        SettingsIcon(name: "envelope.fill")
                        VStack(alignment: .leading, spacing: 3) {
                            Text("Probleem melden")
                                .appFont(size: 18, weight: .semibold)
                                .foregroundStyle(FN.ink)
                            Text("support@vancoilliestudio.be")
                            .appFont(size: 13, weight: .medium)
                                .foregroundStyle(FN.secondary)
                        }
                        Spacer()
                        Image(systemName: "arrow.up.right")
                            .appFont(size: 14, weight: .bold)
                            .foregroundStyle(FN.tertiary)
                    }
                    .padding(18)
                }

                Divider()
                    .padding(.leading, 70)

                Link(destination: URL(string: "https://www.vancoillieithulp.be/privacyPolicyBrainox.html")!) {
                    HStack(spacing: 14) {
                        SettingsIcon(name: "hand.raised.fill")
                        VStack(alignment: .leading, spacing: 3) {
                            Text("Privacybeleid")
                                .appFont(size: 16, weight: .semibold)
                                .foregroundStyle(FN.ink)
                            Text("Bekijk hoe Brainox omgaat met je gegevens")
                                .appFont(size: 13, weight: .medium)
                                .foregroundStyle(FN.secondary)
                                .fixedSize(horizontal: false, vertical: true)
                        }
                        Spacer()
                        Image(systemName: "arrow.up.right")
                            .appFont(size: 14, weight: .bold)
                            .foregroundStyle(FN.tertiary)
                    }
                    .padding(18)
                }
            }
            .background(FN.card)
            .clipShape(RoundedRectangle(cornerRadius: 28))
        }
    }

    private var reviewTimeText: String {
        String(format: "%02d:%02d", store.reviewHour, store.reviewMinute)
    }

    private var appVersion: String {
        Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? "-"
    }

    private var buildNumber: String {
        Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? "-"
    }

    private var textSizeBinding: Binding<TextSizePreference> {
        Binding {
            store.selectedTextSize
        } set: { newValue in
            store.selectedTextSize = newValue
        }
    }

    private var colorSchemeBinding: Binding<ColorSchemePreference> {
        Binding {
            ColorSchemePreference(rawValue: store.colorSchemePreference) ?? .system
        } set: { newValue in
            store.colorSchemePreference = newValue.rawValue
        }
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
                .appFont(size: 18, weight: .semibold)
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
                .appFont(size: 18, weight: .semibold)
                .foregroundStyle(FN.ink)
            Text(label)
                .appFont(size: 11, weight: .semibold)
                .foregroundStyle(FN.secondary)
        }
        .frame(maxWidth: .infinity)
        .padding(.vertical, 10)
        .background(FN.surface)
        .clipShape(RoundedRectangle(cornerRadius: 14))
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
                        .appFont(size: 16, weight: .semibold)
                        .foregroundStyle(FN.ink)
                    Text(subtitle)
                        .appFont(size: 13, weight: .medium)
                        .foregroundStyle(FN.secondary)
                        .fixedSize(horizontal: false, vertical: true)
                }

                Spacer()

                Image(systemName: "chevron.right")
                    .appFont(size: 14, weight: .bold)
                    .foregroundStyle(FN.tertiary)
            }
            .padding(16)
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
                    .appFont(size: 16, weight: .semibold)
                    .foregroundStyle(FN.ink)
                Text(subtitle)
                    .appFont(size: 13, weight: .medium)
                    .foregroundStyle(FN.secondary)
                    .fixedSize(horizontal: false, vertical: true)
            }

            Spacer()

            Toggle("", isOn: $isOn)
                .labelsHidden()
                .tint(FN.ink)
        }
        .padding(16)
    }
}

private struct SettingsIcon: View {
    let name: String

    var body: some View {
        Image(systemName: name)
            .appFont(size: 16, weight: .semibold)
            .foregroundStyle(FN.ink)
            .frame(width: 34, height: 34)
            .background(FN.surface)
            .clipShape(RoundedRectangle(cornerRadius: 11))
    }
}
