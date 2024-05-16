import SwiftUI

/// Displays the controls for initiating and monitoring
/// transcription of the text from a dropped audio file.
struct TranscriptionView: View {
    @Environment(\.rootViewModel) var viewModel
    
    var body: some View {
        VStack {
            if viewModel.transcriptionText == nil {
                Button(action: viewModel.transcribeAudio) {
                    Label("Transcribe", systemImage: "waveform")
                }
                .disabled(viewModel.isTranscribing)
            }

            Spacer()
            Group {
                if viewModel.isTranscribing {
                    Text("transcribing…")
                        .font(.title2)
                } else if let text = viewModel.transcriptionText {
                    Text(text)
                        .multilineTextAlignment(.leading)
                        .textSelection(.enabled)
                }
            }
            .frame(maxWidth: 300)

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

#Preview {
    TranscriptionView()
}
