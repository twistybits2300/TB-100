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
        Button(action: viewModel.transcribeAudio) {
            Label(buttonText, systemImage: "waveform")
        }
        .disabled(isDisabled)
    }

    private var buttonText: String {
        viewModel.isTranscribing ? "transcribing…" : "Transcribe"
    }
    
    private var isDisabled: Bool {
        return viewModel.isTranscribing
    }
}

/// Displays text indicating the transcription is in progress, and
/// when it's completed the text captured from the transcription.
private struct TranscriptionStateView: View {
    @Environment(\.rootViewModel) var viewModel
    @State private var text = ""
    
    var body: some View {
        if viewModel.transcriptionText != nil {
            @Bindable var model = viewModel
            VStack(spacing: 5) {
                HeaderView()
                TextEditor(text: $text)
                    .multilineTextAlignment(.leading)
                    .textSelection(.enabled)
                    .padding()
            }
            .onReceive(viewModel.transcriptionText.publisher) { value in
                self.text = value
                viewModel.onTranscriptionTextChanged(text: value)
            }
        }
    }
}

extension TranscriptionStateView {
    /// Displays some headline text with an image from which the user can tap to copy
    /// the current contents of the `TextEditor` to the system clipboard, along with
    /// the name of the file for which the transcription text is being shown.
    private struct HeaderView: View {
        @Environment(\.rootViewModel) var viewModel
        
        var body: some View {
            VStack {
                HStack {
                    Text("Transcribed Text")
                        .font(.headline)
                    Image(systemName: copyIconName)
                        .imageScale(.medium)
                        .onTapGesture(perform: viewModel.copyTranscribedTextToClipboard)
                }
                Text(selectedFilename)
                    .font(.callout)
            }
        }
        
        private var copyIconName: String {
            viewModel.didCopyToClipboard ? "list.clipboard.fill" : "list.clipboard"
        }

        private var selectedFilename: String {
            viewModel.selectedFilename ?? ""
        }
    }
}

// MARK: - Preview
#Preview {
    TranscribedTextView()
}
