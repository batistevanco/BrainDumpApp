import SwiftUI
import UIKit

struct CaptureView: View {
    @EnvironmentObject private var store: BrainDumpStore
    @StateObject private var speech = SpeechController()
    @State private var text = ""
    @State private var selectedType: FlowItemType? = nil
    @State private var savedPulse = false
    @FocusState private var isFocused: Bool

    var body: some View {
        VStack(alignment: .leading, spacing: 16) {
            Text(Date().formatted(.dateTime.weekday(.wide).day().month(.wide).locale(Locale(identifier: "nl_BE"))).capitalized)
                .appFont(size: 17, weight: .medium)
                .foregroundStyle(FN.secondary)
                .padding(.horizontal, 4)

            ZStack(alignment: .topLeading) {
                TextEditor(text: $text)
                    .focused($isFocused)
                    .appFont(size: 22)
                    .foregroundStyle(FN.ink)
                    .scrollContentBackground(.hidden)
                    .padding(.horizontal, 18)
                    .padding(.vertical, 18)
                    .frame(maxHeight: .infinity)
                    .background(FN.surface)
                    .clipShape(RoundedRectangle(cornerRadius: 21))
                if text.isEmpty {
                    Text("Vrijdag de presentatie voor\nde klant nog afwerken")
                        .appFont(size: 22)
                        .foregroundStyle(FN.ink.opacity(0.25))
                        .lineSpacing(8)
                        .padding(.horizontal, 24)
                        .padding(.vertical, 26)
                        .allowsHitTesting(false)
                }
                VStack {
                    Spacer()
                    HStack {
                        Text("\(text.count) tekens")
                            .appFont(size: 17)
                            .foregroundStyle(FN.secondary)
                        Spacer()
                    }
                    .padding(.horizontal, 24)
                    .padding(.bottom, 22)
                }
            }
            .frame(maxHeight: .infinity)

            HStack(spacing: 8) {
                ForEach(FlowItemType.allCases) { type in
                    Button {
                        isFocused = false
                        withAnimation(.spring(response: 0.25, dampingFraction: 0.7)) {
                            selectedType = selectedType == type ? nil : type
                        }
                    } label: {
                        HStack(spacing: 6) {
                            Image(systemName: type.icon)
                            Text(type.label)
                        }
                        .appFont(size: 14, weight: .medium)
                        .foregroundStyle(selectedType == type ? type.color : FN.secondary)
                        .padding(.horizontal, 12)
                        .padding(.vertical, 8)
                        .background(selectedType == type ? type.color.opacity(0.12) : FN.surface)
                        .clipShape(RoundedRectangle(cornerRadius: 10))
                        .overlay(
                            RoundedRectangle(cornerRadius: 10)
                                .stroke(selectedType == type ? type.color.opacity(0.4) : Color.clear, lineWidth: 1.5)
                        )
                    }
                    .buttonStyle(.plain)
                }
                Spacer()
            }

            PrimaryButton(title: savedPulse ? "Opgeslagen" : "Opslaan", disabled: text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty) {
                isFocused = false
                if store.stopDictationAfterSave {
                    speech.stop()
                }
                store.addItem(text, type: selectedType)
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
                withAnimation(.easeInOut(duration: 0.2)) {
                    text = ""
                    selectedType = nil
                    savedPulse = true
                }
                Task {
                    try? await Task.sleep(for: .seconds(1.1))
                    await MainActor.run { savedPulse = false }
                }
            }

            if store.isDictationEnabled {
                Button {
                    isFocused = false
                    speech.toggleRecording()
                } label: {
                    HStack(spacing: 14) {
                        Spacer()
                        Image(systemName: speech.isRecording ? "stop.fill" : "mic.fill")
                            .appFont(size: 22)
                            .foregroundStyle(FN.ink)
                            .frame(width: 50, height: 50)
                            .background(FN.surface)
                            .clipShape(Circle())
                        Text(speech.isRecording ? "Luisteren..." : "Of dicteer je gedachte")
                            .appFont(size: 18)
                            .foregroundStyle(FN.secondary)
                        Spacer()
                    }
                }
                .buttonStyle(.plain)
            }
        }
        .padding(.horizontal, 20)
        .padding(.top, 8)
        .padding(.bottom, 20)
        .simultaneousGesture(
            DragGesture(minimumDistance: 12)
                .onChanged { _ in isFocused = false }
        )
        .ignoresSafeArea(.keyboard, edges: .bottom)
        .onChange(of: speech.transcript) { _, newValue in
            guard !newValue.isEmpty else { return }
            text = newValue
        }
        .onChange(of: store.isDictationEnabled) { _, enabled in
            if !enabled {
                speech.stop()
            }
        }
    }
}
