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

    var navigationTitle: String {
        switch self {
        case .capture: "Wat zit er in je hoofd?"
        case .list: "Lijst"
        case .review: "Daily Review"
        case .search: "Zoek"
        }
    }
}
