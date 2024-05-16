import Foundation
import AVFoundation

@Observable
final class AudioFilePlayer {
    private var audioPlayer: AVAudioPlayer? = nil
    
    func play(filePath: String) {
        let url = URL(fileURLWithPath: filePath)
        do {
            audioPlayer = try AVAudioPlayer(contentsOf: url)
            audioPlayer?.play()
        } catch {
            print("Error playing audio file: \(error)")
        }
    }
}
