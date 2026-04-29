import Foundation

enum FlowItemStatus: String, Codable, CaseIterable, Identifiable {
    case open
    case completed
    case saved

    var id: String { rawValue }

    var label: String {
        switch self {
        case .open: "open"
        case .completed: "voltooid"
        case .saved: "bewaard"
        }
    }
}

struct FlowItem: Identifiable, Codable, Equatable {
    var id: UUID
    var text: String
    var createdAt: Date
    var updatedAt: Date
    var status: FlowItemStatus
    var reviewedAt: Date?

    init(
        id: UUID = UUID(),
        text: String,
        createdAt: Date = Date(),
        updatedAt: Date = Date(),
        status: FlowItemStatus = .open,
        reviewedAt: Date? = nil
    ) {
        self.id = id
        self.text = text
        self.createdAt = createdAt
        self.updatedAt = updatedAt
        self.status = status
        self.reviewedAt = reviewedAt
    }
}
