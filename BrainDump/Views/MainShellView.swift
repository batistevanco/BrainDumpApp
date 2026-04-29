import SwiftUI

struct MainShellView: View {
    @State private var selected: FlowTab = .capture

    var body: some View {
        NavigationStack {
            TabView(selection: $selected) {
                CaptureView()
                    .tabItem {
                        Label(FlowTab.capture.rawValue, systemImage: FlowTab.capture.icon)
                    }
                    .tag(FlowTab.capture)

                ItemsListView()
                    .tabItem {
                        Label(FlowTab.list.rawValue, systemImage: FlowTab.list.icon)
                    }
                    .tag(FlowTab.list)

                DailyReviewView()
                    .tabItem {
                        Label(FlowTab.review.rawValue, systemImage: FlowTab.review.icon)
                    }
                    .tag(FlowTab.review)

                SearchView()
                    .tabItem {
                        Label(FlowTab.search.rawValue, systemImage: FlowTab.search.icon)
                    }
                    .tag(FlowTab.search)
            }
            .toolbarBackgroundVisibility(.automatic, for: .tabBar)
            .tint(FN.ink)
            .navigationTitle(selected.navigationTitle)
            .navigationBarTitleDisplayMode(.large)
            .toolbarBackgroundVisibility(.automatic, for: .navigationBar)
            .toolbar {
                ToolbarItem(placement: .topBarLeading) {
                    if selected == .capture {
                        MascotIcon(size: 34)
                            .accessibilityLabel("Brainox")
                    }
                }
                
                ToolbarItem(placement: .topBarTrailing) {
                    SettingsButton()
                }
            }
            .onOpenURL { url in
                if url.scheme == "braindump", url.host == "capture" {
                    selected = .capture
                }
            }
        }
    }
}
