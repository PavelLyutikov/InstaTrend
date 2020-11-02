import WebKit

class WebViewController: UIViewController, WKNavigationDelegate {
    
    var instagramApi: InstagramApi?
    var testUserData: InstagramTestUser?
    var mainVC: ProfileCollectionViewController?
    
    @IBOutlet var webView: WKWebView! {
        didSet {
            webView.navigationDelegate = self
        }
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        instagramApi?.authorizeApp { (url) in
            DispatchQueue.main.async {
                self.webView.load(URLRequest(url: url!))
            }
        }
    }
    
    func webView(_ webView: WKWebView, decidePolicyFor navigationAction: WKNavigationAction, decisionHandler: @escaping (WKNavigationActionPolicy) -> Void) {
        let request = navigationAction.request
        
        self.instagramApi?.getTestUserIDAndToken(request: request) { [weak self] (instagramTestUser) in
            self?.testUserData = instagramTestUser

            DispatchQueue.main.async {
                
                self?.performSegue(withIdentifier: "profileSegue", sender: nil)
            }
       }
        
       decisionHandler(WKNavigationActionPolicy.allow)
    }

}
