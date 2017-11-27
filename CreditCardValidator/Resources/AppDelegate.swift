import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {

        UINavigationBar.appearance().barTintColor = #colorLiteral(red: 0.09889116287, green: 0.1068704592, blue: 0.1170880085, alpha: 1)
        UINavigationBar.appearance().tintColor = UIColor.white
        UINavigationBar.appearance().titleTextAttributes = [NSAttributedStringKey.foregroundColor:UIColor.white]

        window = UIWindow(frame: UIScreen.main.bounds)
        if let window = window {
            let creditCardValidatorController = CreditCardValidatorController()
            let navigationController = UINavigationController(rootViewController: creditCardValidatorController)
            window.rootViewController = navigationController

            window.makeKeyAndVisible()
        }

        return true
    }
}
