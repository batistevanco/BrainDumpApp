import AVFoundation
import Speech
import SwiftUI

@MainActor
final class SpeechController: NSObject, ObservableObject {
    @Published var isRecording = false
    @Published var transcript = ""

    private let recognizer = SFSpeechRecognizer(locale: Locale(identifier: "nl-BE"))
    private let audioEngine = AVAudioEngine()
    private var request: SFSpeechAudioBufferRecognitionRequest?
    private var task: SFSpeechRecognitionTask?

    func toggleRecording() {
        isRecording ? stop() : start()
    }

    func stop() {
        audioEngine.stop()
        request?.endAudio()
        task?.cancel()
        request = nil
        task = nil
        isRecording = false
    }

    private func start() {
        SFSpeechRecognizer.requestAuthorization { [weak self] speechStatus in
            let handleMicrophonePermission: (Bool) -> Void = { micAllowed in
                Task { @MainActor in
                    guard speechStatus == .authorized, micAllowed else { return }
                    self?.startSession()
                }
            }
            if #available(iOS 17.0, *) {
                AVAudioApplication.requestRecordPermission(completionHandler: handleMicrophonePermission)
            } else {
                AVAudioSession.sharedInstance().requestRecordPermission(handleMicrophonePermission)
            }
        }
    }

    private func startSession() {
        stop()
        transcript = ""

        let session = AVAudioSession.sharedInstance()
        try? session.setCategory(.record, mode: .measurement, options: .duckOthers)
        try? session.setActive(true, options: .notifyOthersOnDeactivation)

        request = SFSpeechAudioBufferRecognitionRequest()
        guard let request else { return }
        request.shouldReportPartialResults = true

        let input = audioEngine.inputNode
        let format = input.outputFormat(forBus: 0)
        input.removeTap(onBus: 0)
        input.installTap(onBus: 0, bufferSize: 1024, format: format) { buffer, _ in
            request.append(buffer)
        }

        audioEngine.prepare()
        try? audioEngine.start()
        isRecording = true

        task = recognizer?.recognitionTask(with: request) { [weak self] result, error in
            Task { @MainActor in
                if let result {
                    self?.transcript = result.bestTranscription.formattedString
                }
                if error != nil || result?.isFinal == true {
                    self?.stop()
                }
            }
        }
    }
}
