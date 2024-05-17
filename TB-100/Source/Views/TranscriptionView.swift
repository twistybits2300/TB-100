import SwiftUI

/// Displays the controls for initiating and monitoring
/// transcription of the text from a dropped audio file.
struct TranscriptionView: View {
    @Environment(\.rootViewModel) var viewModel
    
    var body: some View {
        VStack {
            Spacer()
            DroppedFileView()
            TranscribedTextView()
            Spacer()
            footerView
        }
        .onAppear {
            viewModel.requestSpeechRecognitionPermission()
        }
    }
    
    @ViewBuilder
    private var footerView: some View {
        Button(action: viewModel.resetForAnotherDrop) {
            Label("Reset", systemImage: "arrow.triangle.capsulepath")
                .imageScale(.large)
        }
        if viewModel.isSpeechAvailable {
            Text("speech recognition permission: \(viewModel.recognizerStatus)")
        }
    }
}

// MARK: - Preview
#Preview {
    TranscriptionView()
}
