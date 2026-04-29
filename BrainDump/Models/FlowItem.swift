import Foundation
import SwiftUI

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

    var icon: String {
        switch self {
        case .open: "circle"
        case .completed: "checkmark.circle.fill"
        case .saved: "bookmark.fill"
        }
    }

    var color: Color {
        switch self {
        case .open: Color(red: 0.612, green: 0.639, blue: 0.686)
        case .completed: Color(red: 0.114, green: 0.620, blue: 0.459)
        case .saved: Color(red: 0.318, green: 0.502, blue: 0.933)
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
