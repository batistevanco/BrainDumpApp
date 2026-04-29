import SwiftUI

@main
struct BrainDumpApp: App {
    @StateObject private var store = BrainDumpStore()

    var body: some Scene {
        WindowGroup {
            RootView()
                .environmentObject(store)
                .preferredColorScheme(.light)
        }
    }
}
