import SwiftUI

/// The app's root view.
struct RootView: View {
    @Environment(\.rootViewModel) var viewModel
    
    var body: some View {
        VStack {
            if let fileURL = fileDrop.droppedFileURL {
                Text("dropped \(fileURL.lastPathComponent)")
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
    
    private var fileDrop: AudioFileDrop {
        viewModel.fileDrop
    }
}

#Preview {
    RootView()
}