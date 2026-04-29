import XCTest
@testable import BrainDump

final class BrainDumpBackupTests: XCTestCase {
    func testBackupRoundTripsThroughSharedJSONCoder() throws {
        let createdAt = try XCTUnwrap(DateComponents(calendar: .current, year: 2026, month: 4, day: 29, hour: 10).date)
        let backup = BrainDumpBackup(
            exportedAt: createdAt,
            items: [
                FlowItem(
                    id: UUID(uuidString: "11111111-1111-1111-1111-111111111111")!,
                    text: "Test item",
                    createdAt: createdAt,
                    updatedAt: createdAt,
                    status: .saved,
                    reviewedAt: createdAt
                )
            ],
            reviewHour: 21,
            reviewMinute: 30
        )

        let data = try BrainDumpStore.encoder.encode(backup)
        let decoded = try BrainDumpStore.decoder.decode(BrainDumpBackup.self, from: data)

        XCTAssertEqual(decoded.items, backup.items)
        XCTAssertEqual(decoded.reviewHour, 21)
        XCTAssertEqual(decoded.reviewMinute, 30)
        XCTAssertEqual(decoded.exportedAt, createdAt)
    }
}
