import XCTest
@testable import BrainDump

@MainActor
final class BrainDumpStoreTests: XCTestCase {
    private var storageURL: URL!

    override func setUpWithError() throws {
        try super.setUpWithError()
        storageURL = FileManager.default.temporaryDirectory
            .appendingPathComponent(UUID().uuidString)
            .appendingPathExtension("json")
    }

    override func tearDownWithError() throws {
        if let storageURL {
            try? FileManager.default.removeItem(at: storageURL)
        }
        storageURL = nil
        try super.tearDownWithError()
    }

    func testAddItemTrimsTextAndPersistsNewestFirst() {
        let store = makeStore()

        store.addItem("  Eerste gedachte  ")
        store.addItem("\nTweede gedachte\n")
        store.addItem("   ")

        XCTAssertEqual(store.items.map(\.text), ["Tweede gedachte", "Eerste gedachte"])
        XCTAssertEqual(store.items.allSatisfy { $0.status == .open }, true)

        let reloaded = makeStore()
        XCTAssertEqual(reloaded.items.map(\.text), ["Tweede gedachte", "Eerste gedachte"])
    }

    func testUpdateItemTrimsTextAndRefreshesUpdatedAt() throws {
        let store = makeStore()
        store.addItem("Origineel")
        let item = try XCTUnwrap(store.items.first)
        let previousUpdatedAt = item.updatedAt

        store.updateItem(item, text: "  Aangepast  ")

        let updated = try XCTUnwrap(store.items.first)
        XCTAssertEqual(updated.text, "Aangepast")
        XCTAssertGreaterThanOrEqual(updated.updatedAt, previousUpdatedAt)
    }

    func testSetStatusMarksItemAsReviewed() throws {
        let store = makeStore()
        store.addItem("Afwerken")
        let item = try XCTUnwrap(store.items.first)

        store.setStatus(item, status: .completed)

        let updated = try XCTUnwrap(store.items.first)
        XCTAssertEqual(updated.status, .completed)
        XCTAssertNotNil(updated.reviewedAt)
    }

    func testDeleteRemovesMatchingItemOnly() throws {
        let store = makeStore()
        store.addItem("Blijft")
        store.addItem("Verdwijnt")
        let itemToDelete = try XCTUnwrap(store.items.first)

        store.delete(itemToDelete)

        XCTAssertEqual(store.items.map(\.text), ["Blijft"])
    }

    func testTodayItemsAndReviewQueueFilterStatuses() {
        let store = makeStore()
        let now = Date()
        let yesterday = Calendar.current.date(byAdding: .day, value: -1, to: now)!

        store.items = [
            FlowItem(text: "Vandaag open", createdAt: now, updatedAt: now),
            FlowItem(text: "Vandaag bewaard", createdAt: now, updatedAt: now, status: .saved),
            FlowItem(text: "Vandaag klaar", createdAt: now, updatedAt: now, status: .completed),
            FlowItem(text: "Gisteren open", createdAt: yesterday, updatedAt: yesterday)
        ]

        XCTAssertEqual(store.todayItems.map(\.text), ["Vandaag open", "Vandaag bewaard", "Vandaag klaar"])
        XCTAssertEqual(store.reviewQueue.map(\.text), ["Vandaag open", "Vandaag bewaard"])
    }

    private func makeStore() -> BrainDumpStore {
        BrainDumpStore(storageURL: storageURL, seedSampleData: false)
    }
}
