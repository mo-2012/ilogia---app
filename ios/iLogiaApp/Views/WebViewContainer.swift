import SwiftUI
import WebKit

struct WebViewContainer: UIViewRepresentable {
    let url: URL
    @Binding var canGoBack: Bool
    @Binding var isLoading: Bool
    var webView: WKWebView

    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }

    func makeUIView(context: Context) -> WKWebView {
        webView.navigationDelegate = context.coordinator
        webView.uiDelegate = context.coordinator
        webView.allowsBackForwardNavigationGestures = true
        webView.scrollView.bounces = true
        webView.isOpaque = false
        webView.backgroundColor = UIColor(named: "BackgroundNavy") ?? UIColor(red: 16/255, green: 29/255, blue: 54/255, alpha: 1.0)

        // Custom standard Mobile Safari User-Agent (No IlogiaApp suffix to avoid html.app #app hiding)
        webView.customUserAgent = "Mozilla/5.0 (iPhone; CPU iPhone OS 17_5 like Mac OS X) AppleWebKit/605.1.15 (KHTML, like Gecko) Version/17.5 Mobile/15E148 Safari/604.1"

        let request = URLRequest(url: url)
        webView.load(request)
        return webView
    }

    func updateUIView(_ uiView: WKWebView, context: Context) {
        // Navigation updates handled via coordinator
    }

    class Coordinator: NSObject, WKNavigationDelegate, WKUIDelegate {
        var parent: WebViewContainer

        init(_ parent: WebViewContainer) {
            self.parent = parent
        }

        func webView(_ webView: WKWebView, didStartProvisionalNavigation navigation: WKNavigation!) {
            parent.isLoading = true
        }

        func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
            parent.isLoading = false
            parent.canGoBack = webView.canGoBack

            // Inject CSS polishing (hide download banners on index.html, ensure profile #app is visible)
            let cssScript = """
                var s = document.getElementById('ios-native-styles');
                if (!s) {
                    s = document.createElement('style');
                    s.id = 'ios-native-styles';
                    s.innerHTML = 'section.appx, section#app, #apkBtn, .stores, a[href*=".apk"], .hero .fx { display: none !important; } main#app, #app:not(section) { display: block !important; visibility: visible !important; opacity: 1 !important; }';
                    (document.head || document.documentElement).appendChild(s);
                }
            """
            webView.evaluateJavaScript(cssScript, completionHandler: nil)
        }

        func webView(_ webView: WKWebView, didFail navigation: WKNavigation!, withError error: Error) {
            parent.isLoading = false
        }

        func webView(_ webView: WKWebView, didFailProvisionalNavigation navigation: WKNavigation!, withError error: Error) {
            parent.isLoading = false
        }

        // Handle target="_blank" links inside the same WKWebView
        func webView(_ webView: WKWebView, createWebViewWith configuration: WKWebViewConfiguration, for navigationAction: WKNavigationAction, windowFeatures: WKWindowFeatures) -> WKWebView? {
            if navigationAction.targetFrame == nil {
                webView.load(navigationAction.request)
            }
            return nil
        }
    }
}
