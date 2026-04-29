import SwiftUI
import UIKit

struct MascotIcon: View {
    var size: CGFloat = 44

    private var image: UIImage? {
        if let url = Bundle.main.url(forResource: "BrainDumpMascot", withExtension: "png") {
            return UIImage(contentsOfFile: url.path)
        }

        return UIImage(named: "BrainDumpMascot")
    }

    var body: some View {
        ZStack {
            FN.ink

            if let image {
                Image(uiImage: image)
                    .resizable()
                    .renderingMode(.original)
                    .scaledToFit()
                    .scaleEffect(1.28)
                    .offset(y: size * 0.06)
                    .padding(size * 0.11)
            } else {
                Image(systemName: "brain.head.profile")
                    .font(.system(size: size * 0.48, weight: .semibold))
                    .foregroundStyle(FN.surface)
            }
        }
        .frame(width: size, height: size)
        .clipShape(RoundedRectangle(cornerRadius: size * 0.28))
        .accessibilityLabel("BrainDump mascotte")
    }
}
