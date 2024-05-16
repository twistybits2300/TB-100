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
                    VStack(spacing: 5) {
                        Text("Transcribed Text")
                            .font(.title3)
                        Text(text)
                            .multilineTextAlignment(.leading)
                            .textSelection(.enabled)
                            .padding()
                            .border(.gray)
                        Image(systemName: "list.clipboard.fill")
                            .imageScale(.large)
                            .onTapGesture {
                                viewModel.copyTranscribedTextToClipboard()
                            }
                        Text(copyToClipboardText)
                            .font(.caption)
                    }
                }
            }
            .frame(maxWidth: 500)

            Spacer()
            if viewModel.isSpeechAvailable {
                Text("recognition permission status: \(viewModel.recognizerStatus)")
            }
        }
        .onAppear {
            viewModel.requestSpeechRecognitionPermission()
        }
    }
    
    private var copyToClipboardText: String {
        viewModel.didCopyToClipboard ? "copied to clipboard" : "copy to clipboard"
    }
}

#Preview {
    TranscriptionView()
}
