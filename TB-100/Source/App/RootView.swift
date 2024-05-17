import SwiftUI

/// The app's root view.
struct RootView: View {
    @Environment(\.rootViewModel) var viewModel
    
    var body: some View {
        VStack {
            if viewModel.isFileDropped {
                if viewModel.multipleFilesDropped {
                    HStack {
                        DroppedFilesList()
                        droppedFileTranscriptionView
                            .border(.red)
                    }
                    .border(.blue)
                } else {
                    droppedFileTranscriptionView
                }
            } else {
                DropPromptView()
            }
        }
        .padding()
        .dropDestination(for: URL.self) { urls, _ in
            fileDrop.handleDrop(of: urls)
            return true
        }
    }
    
    @ViewBuilder
    private var droppedFileTranscriptionView: some View {
        VStack {
            DroppedFileView()
            TranscriptionView()
        }
    }
    
    private var fileDrop: AudioFileDrop {
        viewModel.fileDrop
    }
}

#Preview {
    RootView()
}
