import UIKit
import Turbolinks

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
    var window: UIWindow?
    var navigationController = UINavigationController()
    var session = Session()
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        window?.rootViewController = navigationController
        session.delegate = self
        visit(URL: URL(string: "https://mimosaworks.com")!, action: .Advance)
        return true
    }
    
    func visit(URL: URL, action: Action) {
        //        let visitable = VisitableViewController(url: URL)
        //
        //        navigationController.pushViewController(visitable, animated: true)
        //        session.visit(visitable)
        
        
        let visitable = VisitableViewController(url: URL)
        switch action {
        case .Advance:
            navigationController.pushViewController(visitable, animated: true)
            break
        case .Replace:
            navigationController.popViewController(animated: false)
            navigationController.pushViewController(visitable, animated: false)
            break
        default:
            navigationController.pushViewController(visitable, animated: true)
            break
        }
        session.visit(visitable)
    }
    
}

extension AppDelegate: SessionDelegate {
    func session(_ session: Session, didProposeVisitToURL URL: URL, withAction action: Action) {
        visit(URL: URL, action: action)
    }
    
    func session(_ session: Session, didFailRequestForVisitable visitable: Visitable, withError error: NSError) {
        let alert = UIAlertController(title: "Error", message: error.localizedDescription, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
        navigationController.present(alert, animated: true, completion: nil)
    }
}
