import UIKit
import WebKit

final class MovieSiteViewController: BaseViewController {
    
    var handler: MovieSiteEventHandler!
    
    private var activityBag: ActivityDisposable?
    @IBOutlet weak var webView: WKWebView!
    
    // MARK: - Life Cycle
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupViews()
        handler.didLoad()
    }
    
    // MARK: - Private

    private func setupViews() {
        self.webView.apply {
            $0.alpha = 0
            $0.navigationDelegate = self
        }
    }
}

// MARK: - Extensions

extension MovieSiteViewController: WKNavigationDelegate {
    func webView(_ webView: WKWebView, didFinish navigation: WKNavigation!) {
        self.activityBag = nil
        UIView.animate(withDuration: 0.3) {
            self.webView.alpha = 1
        }
    }
}

extension MovieSiteViewController: MovieSiteBehavior {
    func set(url: URL) {
        self.webView.load(URLRequest(url: url))
        self.activityBag = showLoading(fullscreen: false)
    }
}
