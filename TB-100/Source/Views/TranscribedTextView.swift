import SwiftUI

/// Displays a message indicating the transcription is in progress,
/// and when it's done it shows the text from the transcription.
struct TranscribedTextView: View {
    @Environment(\.rootViewModel) var viewModel
    
    var body: some View {
        Group {
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
                }
            }
        }
        .frame(maxWidth: 500)
    }
    
    private var copyIconName: String {
        viewModel.didCopyToClipboard ? "list.clipboard.fill" : "list.clipboard"
    }
}

#Preview {
    TranscribedTextView()
}
