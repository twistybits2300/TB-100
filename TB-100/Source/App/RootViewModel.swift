import SwiftUI

@Observable
/// View model serving the `RootView`
final class RootViewModel {
    var fileDrop = AudioFileDrop()
}

// MARK: - EnvironmentValues
extension EnvironmentValues {
    var rootViewModel: RootViewModel {
        get { self[RootViewModelKey.self] }
        set { self[RootViewModelKey.self] = newValue }
    }

    private struct RootViewModelKey: EnvironmentKey {
        static var defaultValue: RootViewModel {
            .init()
        }
    }
}
