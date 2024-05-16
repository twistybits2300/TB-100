import SwiftUI

@main
struct TB_100App: App {
    @State private var viewModel = RootViewModel()
    
    var body: some Scene {
        WindowGroup {
            RootView()
                .environment(\.rootViewModel, viewModel)
        }
    }
}
