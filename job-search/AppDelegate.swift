import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    var window: UIWindow?
    
    func applicationDidFinishLaunching(application: UIApplication) {
        let key = "hasLaunchedBefore"
        
        let defaults = NSUserDefaults.standardUserDefaults()
        let hasLaunchedBefore = defaults.boolForKey(key)
        
        if hasLaunchedBefore {
            
        } else {
            // show the annoying guider
            defaults.setBool(true, forKey: key)
        }
    }
}

