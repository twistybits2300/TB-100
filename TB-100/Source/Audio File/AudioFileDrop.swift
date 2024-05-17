import Foundation

/// Oversees dropping of audio files onto the app.
@Observable
final class AudioFileDrop {
    /// The URLs of the files that were dropped onto the app.
    var droppedAudioFiles: [DroppedAudioFile] = []
    
    /// The file that's currently selected to be transcribed.
    var selectedFileID: UUID?
    
    /// The currently selected dropped file. May be `nil`.
    var selectedDroppedFile: DroppedAudioFile? {
        droppedFile(by: selectedFileID)
    }

    // MARK: - API
    /// Accepts and processing dropped `urls`
    /// - Parameter urls: The `URL`s to the files that were dropped.
    func handleDrop(of urls: [URL]) {
        guard !urls.isEmpty else {
            return
        }
        
        if urls.count == 1 {
            if let url = urls.first {
                let droppedFile = DroppedAudioFile(url: url)
                droppedAudioFiles.append(droppedFile)
                selectedFileID = droppedFile.id
            }
        } else {
            let sortedURLs = urls.sorted(by: { $0.lastPathComponent < $1.lastPathComponent })
            for url in sortedURLs {
                let pathExtension = url.pathExtension.lowercased()
                guard isAudioFileExtension(pathExtension) else {
                    return
                }
                
                droppedAudioFiles.append(DroppedAudioFile(url: url))
            }

            selectedFileID = droppedAudioFiles.first?.id
        }
    }
    
    /// Returns the dropped audio file matching the given `id`.
    /// - Parameter id: The identifier to search for.
    /// - Returns: The matching file info if found, `nil` otherwise.
    func droppedFile(by id: UUID?) -> DroppedAudioFile? {
        guard let id = id else {
            return nil
        }
        
        guard !droppedAudioFiles.isEmpty else {
            return nil
        }
        
        for file in droppedAudioFiles {
            if file.id == id {
                return file
            }
        }
        
        return nil
    }
    
    /// Resets to the default state.
    func reset() {
        selectedFileID = nil
        droppedAudioFiles = []
    }

    // MARK: - Utilities
    private func isAudioFileExtension(_ pathExtension: String) -> Bool {
        audioFileExtensions.contains(pathExtension)
    }
    
    private var audioFileExtensions: [String] {
        ["mp3", "wav", "aif", "aiff", "m4a"]
    }
}

extension URL {
    var filePath: String {
        self.path(percentEncoded: false)
    }
}
