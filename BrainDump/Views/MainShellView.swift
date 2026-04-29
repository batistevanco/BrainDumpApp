import SwiftUI

struct MainShellView: View {
    @State private var selected: FlowTab = .capture

    var body: some View {
        VStack(spacing: 0) {
            ZStack {
                switch selected {
                case .capture: CaptureView()
                case .list: ItemsListView()
                case .review: DailyReviewView()
                case .search: SearchView()
                }
            }
            CustomTabBar(selected: $selected)
        }
    }
}
