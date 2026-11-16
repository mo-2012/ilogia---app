import SwiftUI

@main
struct iLogiaApp: App {
    @StateObject private var networkMonitor = NetworkMonitor()

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environmentObject(networkMonitor)
                .preferredColorScheme(.dark)
        }
    }
}
