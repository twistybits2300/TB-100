import SwiftUI

/// Displayed when the user has dropped an audio file onto the app.
struct DroppedFileView: View {
    @Environment(\.rootViewModel) var viewModel
    
    var body: some View {
        VStack {
            if let fileURL = fileDrop.droppedFileURL {
                HStack {
                    Text("'\(fileURL.lastPathComponent)' was dropped")
                    Image(systemName: viewModel.playerImageName)
                        .imageScale(.large)
                        .onTapGesture {
                            viewModel.togglePlayback()
                        }
                }
            }
        }
    }
    
    private var fileDrop: AudioFileDrop {
        viewModel.fileDrop
    }
}

#Preview {
    DroppedFileView()
}
