import Foundation

@Observable
/// Oversees dropping of audio files onto the app.
final class AudioFileDrop {
    /// This is set to non-`nil` when a dropped file has been accepted.
    var currentDroppedFileURL: URL? = nil
    
    /// The URLs of the files that were dropped onto the app.
    var droppedFileURLs: [URL] = []
    
    /// Accepts and processing dropped `urls`
    /// - Parameter urls: The `URL`s to the files that were dropped.
    func handleDrop(of urls: [URL]) {
        guard !urls.isEmpty else {
            return
        }
        
        if urls.count == 1 {
            currentDroppedFileURL = urls.first
        } else {
            let sortedURLs = urls.sorted(by: { $0.lastPathComponent < $1.lastPathComponent })
            for url in sortedURLs {
                let pathExtension = url.pathExtension.lowercased()
                guard isAudioFileExtension(pathExtension) else {
                    return
                }
                
                droppedFileURLs.append(url)
            }
            currentDroppedFileURL = urls.first
        }
    }
    
    /// Resets to the default state.
    func reset() {
        currentDroppedFileURL = nil
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
