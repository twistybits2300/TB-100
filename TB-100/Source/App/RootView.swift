import SwiftUI

/// The app's root view.
struct RootView: View {
    @Environment(\.rootViewModel) var viewModel
    
    var body: some View {
        VStack {
            if viewModel.isFileDropped {
                DroppedFileView()
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
