import SwiftUI

struct ProgressDots: View {
    let current: Int
    let count: Int

    var body: some View {
        HStack(spacing: 8) {
            ForEach(0..<count, id: \.self) { index in
                Capsule()
                    .fill(index == current ? FN.ink : FN.line)
                    .frame(width: index == current ? 36 : 9, height: 9)
            }
        }
    }
}
