enum FlowTab: String, CaseIterable {
    case capture = "Capture"
    case list = "Lijst"
    case review = "Review"
    case search = "Zoek"

    var icon: String {
        switch self {
        case .capture: "plus.circle"
        case .list: "list.bullet"
        case .review: "checkmark"
        case .search: "magnifyingglass"
        }
    }
}
