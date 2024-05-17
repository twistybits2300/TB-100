import SwiftUI
import Xscriber
import TBCommon

@Observable
/// View model serving the `RootView`
final class RootViewModel {
    /// Handles drops of an audio file.
    var fileDrop = AudioFileDrop()
    
    /// Handles the audio file playback duties.
    var player = AudioFilePlayer()
    
    /// Responsible for transcribing the text from an audio file.
    var transcriber: AudioFileTranscriber?
    
    /// `true` indicates the transcription text has been copied
    /// to the clipboard.
    var didCopyToClipboard: Bool = false
    
    // MARK: - Initialization
    /// Default initializer.
    init() {
        do {
            self.transcriber = try AudioFileTranscriber()
        } catch {
            print("Unable to instantiate transcriber")
        }
    }
    
    /// Returns `true` if the user has dropped an audio
    /// file onto the app and it has been accepted.
    var isFileDropped: Bool {
        fileDrop.selectedFileID != nil || multipleFilesDropped
    }
    
    /// Returns `true` if more than one file was dropped
    /// onto the app.
    var multipleFilesDropped: Bool {
        fileDrop.droppedAudioFiles.count > 1
    }
    
    /// The audio files that were dropped onto the app to
    /// be transcribed.
    var droppedFiles: [DroppedAudioFile] {
        fileDrop.droppedAudioFiles
    }
    
    /// Returns the `systemName` to use for the play/stop icon
    /// based on the state of `player`.
    var playerImageName: String {
        player.isPlaying ? "stop.fill" : "play.fill"
    }
    
    /// Returns `true` if we're currently transcribing the text
    /// from a dropped audio file.
    var isTranscribing: Bool {
        guard let transcriber = transcriber else {
            return false
        }
        
        return transcriber.isTranscribing
    }
    
    /// Returns `true` if speech recognition services are available
    /// on this device, `false` if not.
    var isSpeechAvailable: Bool {
        guard let transcriber = transcriber else {
            return false
        }
        
        return transcriber.isSpeechAvailable
    }
    
    /// Returns the permission status for speech recognition.
    var recognizerStatus: Recognizer.Status {
        guard let transcriber = transcriber else {
            return .notDetermined
        }
        
        return transcriber.recognizerStatus
    }
    
    /// The text that was transcribed from a dropped audio file.
    var transcriptionText: String? {
        transcriber?.transcriptionText
    }
    
    /// Is non-`nil` when errors are encountered during the
    /// transcription process.
    var transcriberError: TranscriberError? {
        transcriber?.error
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
            player.play(fileURL: fileDrop.selectedDroppedFile?.url)
        }
    }
    
    /// Makes the request to the transcriber for the user's permission
    /// to use the speech recognition services.
    func requestSpeechRecognitionPermission() {
        transcriber?.requestPermission()
    }
    
    /// Assuming an audio file has been dropped, kicks
    /// off the transcription of the text from that file.
    func transcribeAudio() {
        guard let fileURL = fileDrop.selectedDroppedFile?.url else {
            return
        }
        
        didCopyToClipboard = false
        
        do {
            try transcriber?.transcribe(fileURL: fileURL)
        } catch {
            print("transcribe failure: \(error.localizedDescription)")
        }
    }
    
    /// If there's transcription text available, it will be copied
    /// onto the generally available clipboard.
    func copyTranscribedTextToClipboard() {
        guard let text = transcriber?.transcriptionText else {
            return
        }
        
        text.putOnPasteboard()
        didCopyToClipboard = true
    }
    
    func resetForAnotherDrop() {
        fileDrop.reset()
        player.reset()
        transcriber?.reset()
        didCopyToClipboard = false
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
