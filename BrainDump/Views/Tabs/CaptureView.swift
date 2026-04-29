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
        VStack(alignment: .leading, spacing: 0) {
            HeaderDateTitle(date: Date(), title: "Wat zit er in je hoofd?", trailing: {
                HStack(spacing: 4) {
                    MascotIcon(size: 44)
                    SettingsButton()
                }
            })

            VStack(spacing: 16) {
                ZStack(alignment: .topLeading) {
                    TextEditor(text: $text)
                        .focused($isFocused)
                        .font(.system(size: 24))
                        .foregroundStyle(FN.ink)
                        .scrollContentBackground(.hidden)
                        .padding(.horizontal, 18)
                        .padding(.vertical, 20)
                        .frame(minHeight: 330)
                        .background(FN.surface)
                        .clipShape(RoundedRectangle(cornerRadius: 24))
                    if text.isEmpty {
                        Text("Vrijdag de presentatie voor\nde klant nog afwerken")
                            .font(.system(size: 24))
                            .foregroundStyle(FN.ink.opacity(0.25))
                            .lineSpacing(8)
                            .padding(.horizontal, 24)
                            .padding(.vertical, 28)
                    }
                    VStack {
                        Spacer()
                        HStack {
                            Text("\(text.count) tekens")
                                .font(.system(size: 20))
                                .foregroundStyle(FN.secondary)
                            Spacer()
                        }
                        .padding(.horizontal, 24)
                        .padding(.bottom, 22)
                    }
                }

                HStack(spacing: 8) {
                    ForEach(FlowItemType.allCases) { type in
                        Button {
                            withAnimation(.spring(response: 0.25, dampingFraction: 0.7)) {
                                selectedType = selectedType == type ? nil : type
                            }
                        } label: {
                            HStack(spacing: 6) {
                                Image(systemName: type.icon)
                                Text(type.label)
                            }
                            .font(.system(size: 16, weight: .medium))
                            .foregroundStyle(selectedType == type ? type.color : FN.secondary)
                            .padding(.horizontal, 14)
                            .padding(.vertical, 10)
                            .background(selectedType == type ? type.color.opacity(0.12) : FN.surface)
                            .clipShape(RoundedRectangle(cornerRadius: 12))
                            .overlay(
                                RoundedRectangle(cornerRadius: 12)
                                    .stroke(selectedType == type ? type.color.opacity(0.4) : Color.clear, lineWidth: 1.5)
                            )
                        }
                        .buttonStyle(.plain)
                    }
                    Spacer()
                }

                PrimaryButton(title: savedPulse ? "Opgeslagen" : "Opslaan", disabled: text.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty) {
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
                        speech.toggleRecording()
                    } label: {
                        HStack(spacing: 14) {
                            Image(systemName: speech.isRecording ? "stop.fill" : "mic.fill")
                                .font(.system(size: 24))
                                .foregroundStyle(FN.ink)
                                .frame(width: 56, height: 56)
                                .background(FN.surface)
                                .clipShape(Circle())
                            Text(speech.isRecording ? "Luisteren..." : "Of dicteer je gedachte")
                                .font(.system(size: 20))
                                .foregroundStyle(FN.secondary)
                        }
                    }
                    .buttonStyle(.plain)
                }
            }
            .padding(.horizontal, 20)
            .padding(.top, 22)

            Spacer()
        }
        .onAppear { isFocused = true }
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
