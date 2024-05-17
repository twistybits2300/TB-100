import SwiftUI

/// Displays a message indicating the transcription is in progress,
/// and when it's done it shows the text from the transcription.
struct TranscribedTextView: View {
    @Environment(\.rootViewModel) var viewModel
    
    var body: some View {
        VStack {
            TranscribeButton()
            TranscriptionStateView()
        }
        .frame(maxWidth: 500)
    }
}

/// Displays the `Transcribe` button.
private struct TranscribeButton: View {
    @Environment(\.rootViewModel) var viewModel
    
    var body: some View {
        if showButton {
            Button(action: viewModel.transcribeAudio) {
                Label("Transcribe", systemImage: "waveform")
            }
        }
    }
    
    private var showButton: Bool {
        viewModel.isTranscribing == false && viewModel.transcriptionText == nil
    }
}

/// Displays text indicating the transcription is in progress, and
/// when it's completed the text captured from the transcription.
private struct TranscriptionStateView: View {
    @Environment(\.rootViewModel) var viewModel
    
    var body: some View {
        if viewModel.isTranscribing {
            Text("transcribing…")
                .font(.title2)
        } else if let text = viewModel.transcriptionText {
            VStack(spacing: 5) {
                HStack {
                    Text("Transcribed Text")
                        .font(.title3)
                    Image(systemName: copyIconName)
                        .imageScale(.medium)
                        .onTapGesture(perform: viewModel.copyTranscribedTextToClipboard)
                }
                ScrollView {
                    Text(text)
                        .multilineTextAlignment(.leading)
                        .textSelection(.enabled)
                        .padding()
                        .border(.gray)
                }
                Button(action: viewModel.resetForAnotherDrop) {
                    Label("Reset", systemImage: "arrow.triangle.capsulepath")
                        .imageScale(.large)
                }
            }
        }
    }
    
    private var copyIconName: String {
        viewModel.didCopyToClipboard ? "list.clipboard.fill" : "list.clipboard"
    }
}
#Preview {
    TranscribedTextView()
}
