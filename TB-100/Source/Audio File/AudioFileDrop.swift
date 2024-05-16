import Foundation

@Observable
/// Oversees dropping of audio files onto the app.
final class AudioFileDrop {
    /// This is set to non-`nil` when a dropped file has been accepted.
    var droppedFileURL: URL? = nil
    
    /// Returns the name of the file that was dropped if `droppedFileURL` is non-`nil`,
    /// `nil` otherwise.
    var droppedFilename: String? {
        droppedFileURL?.lastPathComponent
    }
    
    /// Returns the path to the file that was dropped if `droppedFileURL` is non-`nil`,
    /// `nil` otherwise.
    var droppedFilePath: String? {
        droppedFileURL?.path(percentEncoded: false)
    }
    
    /// Accepts and processing dropped `urls`
    /// - Parameter urls: The `URL`s to the files that were dropped.
    func handleDrop(of urls: [URL]) {
        for url in urls {
            let pathExtension = url.pathExtension.lowercased()
            guard isAudioFileExtension(pathExtension) else {
                return
            }
            
            droppedFileURL = url
        }
    }

    // MARK: - Utilities
    private func isAudioFileExtension(_ pathExtension: String) -> Bool {
        audioFileExtensions.contains(pathExtension)
    }
    
    private var audioFileExtensions: [String] {
        ["mp3", "wav", "aif", "aiff", "m4a"]
    }
}
