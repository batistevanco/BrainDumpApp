import WidgetKit
import SwiftUI

struct CaptureEntry: TimelineEntry {
    let date: Date
}

struct Provider: TimelineProvider {
    func placeholder(in context: Context) -> CaptureEntry {
        CaptureEntry(date: Date())
    }

    func getSnapshot(in context: Context, completion: @escaping (CaptureEntry) -> Void) {
        completion(CaptureEntry(date: Date()))
    }

    func getTimeline(in context: Context, completion: @escaping (Timeline<CaptureEntry>) -> Void) {
        completion(Timeline(entries: [CaptureEntry(date: Date())], policy: .never))
    }
}

struct BrainDumpWidgetView: View {
    var body: some View {
        Link(destination: URL(string: "braindump://capture")!) {
            ZStack {
                Color.white
                VStack(spacing: 10) {
                    ZStack {
                        Circle()
                            .fill(Color(red: 0.067, green: 0.067, blue: 0.067))
                            .frame(width: 52, height: 52)
                        Image(systemName: "plus")
                            .font(.system(size: 22, weight: .medium))
                            .foregroundStyle(.white)
                    }
                    Text("Brainox")
                        .font(.system(size: 13, weight: .medium))
                        .foregroundStyle(Color(red: 0.067, green: 0.067, blue: 0.067))
                }
            }
        }
    }
}

struct BrainDumpWidget: Widget {
    let kind: String = "BrainDumpWidget"

    var body: some WidgetConfiguration {
        StaticConfiguration(kind: kind, provider: Provider()) { _ in
            BrainDumpWidgetView()
                .containerBackground(.white, for: .widget)
        }
        .configurationDisplayName("Brainox")
        .description("Dump snel een gedachte.")
        .supportedFamilies([.systemSmall])
    }
}
