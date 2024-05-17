import Foundation

/// Represents an audio file that was dropped onto the app to be transcribed.
struct DroppedAudioFile: Identifiable {
    /// The dropped file's url
    let url: URL
    
    // MARK: - Identifiable
    var id: String {
        url.path()
    }
}
