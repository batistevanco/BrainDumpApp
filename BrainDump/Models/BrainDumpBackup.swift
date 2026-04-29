import Foundation
import SwiftUI
import UniformTypeIdentifiers

struct BrainDumpBackup: Codable {
    var exportedAt: Date
    var items: [FlowItem]
    var reviewHour: Int
    var reviewMinute: Int
}

extension UTType {
    static var brainDumpBackup: UTType {
        UTType(exportedAs: "be.vancoillie.braindump.backup", conformingTo: .json)
    }
}

struct BrainDumpBackupDocument: FileDocument {
    static var readableContentTypes: [UTType] { [.brainDumpBackup, .json] }

    var backup: BrainDumpBackup

    init(backup: BrainDumpBackup) {
        self.backup = backup
    }

    init(configuration: ReadConfiguration) throws {
        guard let data = configuration.file.regularFileContents else {
            throw CocoaError(.fileReadCorruptFile)
        }
        backup = try BrainDumpStore.decoder.decode(BrainDumpBackup.self, from: data)
    }

    func fileWrapper(configuration: WriteConfiguration) throws -> FileWrapper {
        let data = try BrainDumpStore.encoder.encode(backup)
        return FileWrapper(regularFileWithContents: data)
    }
}
