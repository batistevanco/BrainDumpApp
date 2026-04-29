import SwiftUI

struct SettingsButton: View {
    @State private var showingSettings = false

    var body: some View {
        Button {
            showingSettings = true
        } label: {
            Image(systemName: "ellipsis")
                .font(.system(size: 22, weight: .medium))
                .foregroundStyle(FN.secondary)
                .frame(width: 44, height: 44)
        }
        .sheet(isPresented: $showingSettings) {
            SettingsView()
        }
    }
}
