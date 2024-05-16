import Foundation
import AVFoundation

@Observable
/// Handles playing an audio file.
final class AudioFilePlayer {
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
    func play(filePath: String?) {
        guard let filePath = filePath else {
            return
        }
        
        let url = URL(fileURLWithPath: filePath)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Error playing audio file: \(error)")
        }
    }
}
