import UIKit
import CoreData

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var navController: UINavigationController?
//    var viewController1: RootViewController()
    var viewController1 = LazyViewController()
    let splitVC = UISplitViewController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        navController = UINavigationController()

        self.navController!.pushViewController(viewController1, animated: true)
        
        self.window!.rootViewController = navController
        self.window!.makeKeyAndVisible()
        
        return true
    }

//    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
//        self.navController?.isNavigationBarHidden = false
//        let firstVC = MasterViewController()
//        let secondVC = firstVC.viewContollers.first!
//        splitVC.viewControllers = [firstVC, secondVC]
//        self.window = UIWindow(frame: UIScreen.main.bounds)
//        self.window!.rootViewController = splitVC
//        self.window!.makeKeyAndVisible()
//        return true
//    }
    
    func change(viewController: UIViewController){
        self.splitVC.viewControllers.remove(at: 1)
        self.splitVC.viewControllers.append(viewController)
        splitVC.reloadInputViews()
    }
    func applicationWillResignActive(_ application: UIApplication) {
        // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
        // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
    }

    func applicationDidEnterBackground(_ application: UIApplication) {
        // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
        // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    }

    func applicationWillEnterForeground(_ application: UIApplication) {
        // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
    }

    func applicationDidBecomeActive(_ application: UIApplication) {
        // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    }

    func applicationWillTerminate(_ application: UIApplication) {
        // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
        do {
            try DataController().managedObjectContext.save()
        } catch {
            fatalError("stuff happened")
        }
    }
}

