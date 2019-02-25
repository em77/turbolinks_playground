import UIKit
import WebKit
import Turbolinks

class ApplicationViewController: UINavigationController {
    
    var URL: NSURL {
        return NSURL(string: "\(host)/")!
    }
    private let webViewProcessPool = WKProcessPool()
    
//    private var application: UIApplication {
//        return UIApplication.sharedApplication()
//    }
    
    private lazy var webViewConfiguration: WKWebViewConfiguration = {
        let configuration = WKWebViewConfiguration()
        configuration.processPool = self.webViewProcessPool
        return configuration
    }()
    
    private lazy var session: Session = {
        let session = Session(webViewConfiguration: self.webViewConfiguration)
        session.delegate = self
        return session
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        presentVisitableForSession(session: session, URL: URL)
    }
    
    func presentVisitableForSession(session: Session, URL: NSURL, action: Action = .Advance) {
        let visitable = CustomVisitableViewController(url: URL as URL)
        
        if action == .Advance {
            pushViewController(visitable, animated: true)
        } else if action == .Replace {
            popViewController(animated: false)
            pushViewController(visitable, animated: false)
        }
        
        session.visit(visitable)
    }
    
}

extension ApplicationViewController: SessionDelegate {
    func session(_ session: Session, didProposeVisitToURL URL: URL, withAction action: Action) {
        presentVisitableForSession(session: session, URL: URL as NSURL, action: action)
    }
    
    func session(_ session: Session, didFailRequestForVisitable visitable: Visitable, withError error: NSError) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        present(alert, animated: true, completion: nil)
    }
    
    func sessionDidStartRequest(session: Session) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = true
    }
    
    func sessionDidFinishRequest(session: Session) {
        UIApplication.shared.isNetworkActivityIndicatorVisible = false
    }
}
