import SwiftUI

/// Displays either of two buttons depending on whether a transcription
/// has occurred or not (`Transcribe` if no, `Reset` if yes).
struct TranscriptionButtons: View {
    @Environment(\.rootViewModel) var viewModel
    
    var body: some View {
        if viewModel.transcriptionText == nil {
            Button(action: viewModel.transcribeAudio) {
                Label("Transcribe", systemImage: "waveform")
            }
            .disabled(viewModel.isTranscribing)
        } else {
            Button(action: viewModel.resetForAnotherDrop) {
                Label("Reset", systemImage: "arrow.triangle.capsulepath")
                    .imageScale(.large)
            }
        }
    }
}

// MARK: - Preview
#Preview {
    TranscriptionButtons()
}
