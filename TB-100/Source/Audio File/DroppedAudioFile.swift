import Foundation

/// Represents an audio file that was dropped onto the app to be transcribed.
struct DroppedAudioFile: Identifiable, Hashable {
    /// The dropped file's url
    let url: URL
    
    /// The dropped file's unique identifier.
    let id = UUID()
    
    /// The dropped audio file's name.
    var fileName: String {
        url.lastPathComponent
    }
}
