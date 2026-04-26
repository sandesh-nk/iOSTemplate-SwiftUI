import SwiftUI
import WebKit

struct WebView: UIViewRepresentable {
    let url: URL

    func makeUIView(context: Context) -> WKWebView {
        let config = WKWebViewConfiguration()
        config.allowsInlineMediaPlayback = true
        let webView = WKWebView(frame: .zero, configuration: config)
        webView.allowsBackForwardNavigationGestures = true
        return webView
    }

    func updateUIView(_ webView: WKWebView, context: Context) {
        webView.load(URLRequest(url: url))
    }
}

struct ContentView: View {
    private let targetURL = URL(string: "https://thefeather.ink/chicago/duch/new/d/")!

    var body: some View {
        WebView(url: targetURL)
            .ignoresSafeArea()
    }
}

#Preview {
    ContentView()
}
