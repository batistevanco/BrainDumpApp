import Foundation
import SwiftUI
import UserNotifications

@MainActor
final class BrainDumpStore: ObservableObject {
    @Published var items: [FlowItem] = [] {
        didSet { saveItems() }
    }
    @AppStorage("hasCompletedOnboarding") var hasCompletedOnboarding = false
    @AppStorage("reviewHour") var reviewHour = 20
    @AppStorage("reviewMinute") var reviewMinute = 0
    @AppStorage("isDictationEnabled") var isDictationEnabled = true

    nonisolated static let encoder: JSONEncoder = {
        let encoder = JSONEncoder()
        encoder.outputFormatting = [.prettyPrinted, .sortedKeys]
        encoder.dateEncodingStrategy = .iso8601
        return encoder
    }()

    nonisolated static let decoder: JSONDecoder = {
        let decoder = JSONDecoder()
        decoder.dateDecodingStrategy = .iso8601
        return decoder
    }()

    private let storageURL: URL
    private let shouldSeedSampleData: Bool

    init(storageURL: URL? = nil, seedSampleData: Bool = true) {
        self.storageURL = storageURL ?? FileManager.default
            .urls(for: .documentDirectory, in: .userDomainMask)[0]
            .appendingPathComponent("braindump-items.json")
        self.shouldSeedSampleData = seedSampleData
        loadItems()
        seedIfNeeded()
    }

    var backup: BrainDumpBackup {
        BrainDumpBackup(exportedAt: Date(), items: items, reviewHour: reviewHour, reviewMinute: reviewMinute)
    }

    var todayItems: [FlowItem] {
        items
            .filter { Calendar.current.isDateInToday($0.createdAt) }
            .sorted { $0.createdAt > $1.createdAt }
    }

    var reviewQueue: [FlowItem] {
        todayItems.filter { $0.status == .open }
    }

    var weekCount: Int {
        let weekAgo = Calendar.current.date(byAdding: .day, value: -7, to: Date()) ?? Date()
        return items.filter { $0.createdAt >= weekAgo }.count
    }

    func addItem(_ text: String) {
        let clean = text.trimmingCharacters(in: .whitespacesAndNewlines)
        guard !clean.isEmpty else { return }
        items.insert(FlowItem(text: clean), at: 0)
    }

    func updateItem(_ item: FlowItem, text: String) {
        guard let index = items.firstIndex(where: { $0.id == item.id }) else { return }
        items[index].text = text.trimmingCharacters(in: .whitespacesAndNewlines)
        items[index].updatedAt = Date()
    }

    func setStatus(_ item: FlowItem, status: FlowItemStatus) {
        guard let index = items.firstIndex(where: { $0.id == item.id }) else { return }
        items[index].status = status
        items[index].reviewedAt = Date()
        items[index].updatedAt = Date()
    }

    func delete(_ item: FlowItem) {
        items.removeAll { $0.id == item.id }
    }

    func importBackup(_ document: BrainDumpBackupDocument) {
        items = document.backup.items.sorted { $0.createdAt > $1.createdAt }
        reviewHour = document.backup.reviewHour
        reviewMinute = document.backup.reviewMinute
        hasCompletedOnboarding = true
        scheduleReviewNotification()
    }

    func scheduleReviewNotification(completion: ((Bool) -> Void)? = nil) {
        let hour = reviewHour
        let minute = reviewMinute
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound]) { granted, _ in
            guard granted else {
                Task { @MainActor in completion?(false) }
                return
            }

            let content = UNMutableNotificationContent()
            content.title = "Daily Review"
            content.body = "Verwerk kort wat vandaag in je hoofd zat."
            content.sound = .default

            var components = DateComponents()
            components.hour = hour
            components.minute = minute

            let trigger = UNCalendarNotificationTrigger(dateMatching: components, repeats: true)
            let request = UNNotificationRequest(identifier: "daily-review", content: content, trigger: trigger)
            UNUserNotificationCenter.current().removePendingNotificationRequests(withIdentifiers: ["daily-review"])
            UNUserNotificationCenter.current().add(request) { error in
                Task { @MainActor in completion?(error == nil) }
            }
        }
    }

    private func loadItems() {
        guard let data = try? Data(contentsOf: storageURL),
              let decoded = try? Self.decoder.decode([FlowItem].self, from: data) else {
            return
        }
        items = decoded.sorted { $0.createdAt > $1.createdAt }
    }

    private func saveItems() {
        guard let data = try? Self.encoder.encode(items) else { return }
        try? data.write(to: storageURL, options: [.atomic, .completeFileProtection])
    }

    private func seedIfNeeded() {
        guard shouldSeedSampleData else { return }
        guard items.isEmpty else { return }
        let calendar = Calendar.current
        let now = Date()
        let todayMorning = calendar.date(bySettingHour: 9, minute: 42, second: 0, of: now) ?? now
        let todayLate = calendar.date(bySettingHour: 11, minute: 8, second: 0, of: now) ?? now
        let todayAfternoon = calendar.date(bySettingHour: 14, minute: 23, second: 0, of: now) ?? now
        let yesterday = calendar.date(byAdding: .day, value: -1, to: now) ?? now
        let yesterdayEvening = calendar.date(bySettingHour: 21, minute: 15, second: 0, of: yesterday) ?? yesterday
        let yesterdayAfternoon = calendar.date(bySettingHour: 16, minute: 30, second: 0, of: yesterday) ?? yesterday

        items = [
            FlowItem(text: "Vrijdag presentatie voor klant afwerken", createdAt: todayAfternoon, updatedAt: todayAfternoon),
            FlowItem(text: "Melk kopen", createdAt: todayLate, updatedAt: todayLate, status: .completed, reviewedAt: todayLate),
            FlowItem(text: "Idee: app voor lokale buurthulp", createdAt: todayMorning, updatedAt: todayMorning),
            FlowItem(text: "Mail beantwoorden van Pieter over de offerte", createdAt: yesterdayEvening, updatedAt: yesterdayEvening),
            FlowItem(text: "Boek bestellen: Atomic Habits", createdAt: yesterdayAfternoon, updatedAt: yesterdayAfternoon, status: .saved, reviewedAt: yesterdayAfternoon)
        ]
    }
}
