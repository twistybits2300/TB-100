import SwiftUI

struct DroppedFilesList: View {
    @Environment(\.rootViewModel) var viewModel
    
    var body: some View {
        VStack {
            Text("dropped files")
            List(viewModel.droppedFiles) { droppedFile in
                Text(droppedFile.url.lastPathComponent)
            }
            .frame(maxHeight: .infinity)
        }
    }
}

#Preview {
    DroppedFilesList()
}
