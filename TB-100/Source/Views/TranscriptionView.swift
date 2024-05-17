import SwiftUI

/// Displays the controls for initiating and monitoring
/// transcription of the text from a dropped audio file.
struct TranscriptionView: View {
    @Environment(\.rootViewModel) var viewModel
    
    var body: some View {
        VStack {
            TranscriptionButtons()
            Spacer()
            TranscribedTextView()
            Spacer()
            if viewModel.isSpeechAvailable {
                Text("recognition permission status: \(viewModel.recognizerStatus)")
            }
        }
        .onAppear {
            viewModel.requestSpeechRecognitionPermission()
        }
    }
}

// MARK: - Preview
#Preview {
    TranscriptionView()
}
