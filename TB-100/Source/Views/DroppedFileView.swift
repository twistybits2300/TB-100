import SwiftUI
import Xscriber

/// Displayed when the user has dropped an audio file onto the app.
struct DroppedFileView: View {
    @Environment(\.rootViewModel) var viewModel
    @State private var selectedFileName: String?
    
    var body: some View {
        VStack {
            HStack {
                headerText
                Image(systemName: viewModel.playerImageName)
                    .imageScale(.large)
                    .onTapGesture {
                        viewModel.togglePlayback()
                    }
            }
        }
        .onReceive(viewModel.fileDrop.selectedFile.publisher) { selectedFileID in
            print(String(describing: selectedFileID))
            if let droppedFile = viewModel.fileDrop.droppedFile(by: selectedFileID) {
                selectedFileName = droppedFile.fileName
            }
        }
    }
    
    @ViewBuilder
    private var headerText: some View {
        if viewModel.multipleFilesDropped {
            if let fileName = selectedFileName {
                Text("'\(fileName)' selected")
            }
        } else {
            if let fileURL = fileDrop.currentDroppedFileURL {
                Text("'\(fileURL.lastPathComponent)' was dropped")
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
