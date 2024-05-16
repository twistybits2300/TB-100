import Foundation
import AVFoundation

@Observable
/// Handles playing an audio file.
final class AudioFilePlayer: NSObject {
    /// Does the actual playing of the audio.
    private var audioPlayer: AVAudioPlayer? = nil
    
    // MARK: - API
    /// Returns `true` if we're currently playing audio; `false` otherwise.
    var isPlaying: Bool {
        guard let player = audioPlayer else {
            return false
        }
        return player.isPlaying
    }
    
    /// Starts the playback of the audio file at the given `filePath`. Ignored if it's `nil`.
    /// - Parameter filePath: The path of the file to be played.
    func play(fileURL: URL?) {
        guard let fileURL = fileURL else {
            return
        }
        
        do {
            try configureAudioPlayer(url: fileURL)
            audioPlayer?.play()
        } catch {
            print("Error playing audio file: \(error)")
        }
    }
    
    /// Halts playback if we're currently playing an audio file.
    func stop() {
        audioPlayer?.stop()
        teardownAudioPlayer()
    }
    
    /// Resets to the default state.
    func reset() {
        teardownAudioPlayer()
    }

    // MARK: - Utilities
    private func configureAudioPlayer(url: URL) throws {
        audioPlayer = try AVAudioPlayer(contentsOf: url)
        audioPlayer?.delegate = self
    }
    
    private func teardownAudioPlayer() {
        audioPlayer?.currentTime = 0
        audioPlayer = nil
    }
}

// MARK: - AVAudioPlayerDelegate
extension AudioFilePlayer: AVAudioPlayerDelegate {
    func audioPlayerDidFinishPlaying(_ player: AVAudioPlayer, successfully flag: Bool) {
        teardownAudioPlayer()
    }
}
