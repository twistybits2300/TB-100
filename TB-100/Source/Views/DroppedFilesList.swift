import SwiftUI

/// Displays the names of the files that were dropped onto the app to be transcribed.
/// Single-item selection allowed.
struct DroppedFilesList: View {
    @Environment(\.rootViewModel) var viewModel
    
    var body: some View {
        VStack {
            @Bindable var model = viewModel
            Text("dropped files")
            List(selection: $model.fileDrop.selectedFile) {
                ForEach(viewModel.droppedFiles) { droppedFile in
                    Text(droppedFile.url.lastPathComponent)
                }
            }
            .frame(maxHeight: .infinity)
        }
    }
}

// MARK: - Preview
#Preview {
    DroppedFilesList()
}
