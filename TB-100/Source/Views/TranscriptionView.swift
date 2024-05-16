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
                    HStack {
                        Text(text)
                            .multilineTextAlignment(.leading)
                            .textSelection(.enabled)
                        Image(systemName: "list.clipboard.fill")
                            .imageScale(.large)
                            .padding(.leading, 20)
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
