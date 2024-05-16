import SwiftUI

@Observable
/// View model serving the `RootView`
final class RootViewModel {
    /// Handles drops of an audio file.
    var fileDrop = AudioFileDrop()
    
    /// Handles the audio file playback duties.
    var player = AudioFilePlayer()
    
    /// Returns `true` if the user has dropped an audio
    /// file onto the app and it has been accepted.
    var isFileDropped: Bool {
        fileDrop.droppedFileURL != nil
    }
    
    /// Returns the `systemName` to use for the play/stop icon
    /// based on the state of `player`.
    var playerImageName: String {
        player.isPlaying ? "stop.fill" : "play.fill"
    }
    
    // MARK: - API
    /// Toggles the playback of an audio file has been dropped on
    /// the app and accepted.
    ///
    /// If the app is currently playing audio it is stopped. Otherwise,
    /// the playback is initiated.
    func togglePlayback() {
        guard isFileDropped else {
            return
        }
        
        if player.isPlaying {
            player.stop()
        } else {
            player.play(filePath: fileDrop.droppedFilePath)
        }
    }
}

// MARK: - EnvironmentValues
extension EnvironmentValues {
    var rootViewModel: RootViewModel {
        get { self[RootViewModelKey.self] }
        set { self[RootViewModelKey.self] = newValue }
    }

    private struct RootViewModelKey: EnvironmentKey {
        static var defaultValue: RootViewModel {
            .init()
        }
    }
}
