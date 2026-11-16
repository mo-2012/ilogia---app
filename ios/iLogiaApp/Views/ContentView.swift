import SwiftUI
import WebKit

struct ContentView: View {
    @EnvironmentObject var networkMonitor: NetworkMonitor
    @State private var canGoBack = false
    @State private var isLoading = false
    @State private var webView: WKWebView

    private let initialURL = URL(string: "https://ilogia-eg.com")!

    init() {
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        config.mediaTypesRequiringUserActionForPlayback = []
        config.websiteDataStore = WKWebsiteDataStore.default()

        let wv = WKWebView(frame: .zero, configuration: config)
        _webView = State(initialValue: wv)
    }

    var body: some View {
        ZStack {
            Color(hex: "101D36")
                .ignoresSafeArea()

            if networkMonitor.isConnected {
                VStack(spacing: 0) {
                    if isLoading {
                        ProgressView()
                            .progressViewStyle(LinearProgressViewStyle(tint: Color(hex: "34D399")))
                            .frame(height: 2)
                    }

                    WebViewContainer(
                        url: initialURL,
                        canGoBack: $canGoBack,
                        isLoading: $isLoading,
                        webView: webView
                    )
                    .ignoresSafeArea(.keyboard, edges: .bottom)
                }
            } else {
                OfflineView {
                    if let cur = webView.url {
                        webView.load(URLRequest(url: cur))
                    } else {
                        webView.load(URLRequest(url: initialURL))
                    }
                }
            }
        }
        .onReceive(NotificationCenter.default.publisher(for: UIApplication.willEnterForegroundNotification)) { _ in
            // Refresh webView state if needed
        }
    }
}
