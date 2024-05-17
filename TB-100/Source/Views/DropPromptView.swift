import SwiftUI

/// Displays the prompt to drop audio files on the app to have them transcribed.
struct DropPromptView: View {
    var body: some View {
        Text("Drag and drop audio files here")
            .padding()
            .frame(maxWidth: .infinity, maxHeight: .infinity)
            .background(Color.gray.opacity(0.2))
    }
}

#Preview {
    DropPromptView()
}
