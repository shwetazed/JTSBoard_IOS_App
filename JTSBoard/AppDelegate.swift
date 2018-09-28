//
//  AppDelegate.swift
//  JTSBoard
//
//  Created by jts on 03/07/18.
//  Copyright © 2018 jts. All rights reserved.
//

import UIKit
import SlideMenuControllerSwift
import UserNotifications

fileprivate let viewActionIdentifier = "VIEW_IDENTIFIER"
fileprivate let newsCategoryIdentifier = "NEWS_CATEGORY"

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate{
   
    var window: UIWindow?
    var objDashboardViewController : DashboardViewController?
    var navigationController : UINavigationController?
    var objLoginViewController : LoginViewController?
    var objEmployeeCodeViewController : EmployeeCodeViewController?

    var orientationLock = UIInterfaceOrientationMask.all

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
        
        sleep(4)
        
        ConfigManager.kCheckRootViewController = "dashboard"
        window = UIWindow(frame: UIScreen.main.bounds)
        
        //objMainFromViewController = MainFromViewController(nibName: "MainFromViewController", bundle: nil)
        
        if ConfigManager.DeviceType.IS_IPAD
        {
            objLoginViewController = LoginViewController(nibName: "LoginViewController", bundle: nil)
            navigationController = UINavigationController(rootViewController: objLoginViewController!)
        }
        else
        {
            objEmployeeCodeViewController = EmployeeCodeViewController(nibName: "EmployeeCodeViewController", bundle: nil)
            navigationController = UINavigationController(rootViewController: objEmployeeCodeViewController!)
        }
        
        
        
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()

        registerForPushNotifications()
        UNUserNotificationCenter.current().delegate = self

        // Override point for customization after application launch.
        return true
    }
    
    
    func application(_ application: UIApplication, supportedInterfaceOrientationsFor window: UIWindow?) -> UIInterfaceOrientationMask {
        return self.orientationLock
    }
    func rotated() {
        if UIDeviceOrientationIsLandscape(UIDevice.current.orientation) {
            print("Landscape")
        }
        
        if UIDeviceOrientationIsPortrait(UIDevice.current.orientation) {
            print("Portrait")
        }
        
    }
    func application(application: UIApplication, supportedInterfaceOrientationsForWindow window: UIWindow?) -> UIInterfaceOrientationMask {
        return UIInterfaceOrientationMask.all
    } 
    func setLandingPage()
    {

        window?.rootViewController = nil;
        navigationController = nil
        objLoginViewController = nil

        objDashboardViewController = DashboardViewController(nibName: "DashboardViewController", bundle: nil)
        navigationController = UINavigationController(rootViewController: self.objDashboardViewController!)
        window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }
    
   /* func setLandingPage()
    {
        window?.rootViewController = nil;
        navigationController = nil
        objLoginViewController = nil
        self.objSideMenuViewController = nil


        if ConfigManager.kCheckRootViewController == "dashboard" {
            
            objDashboardViewController = DashboardViewController(nibName: "DashboardViewController", bundle: nil)
            navigationController = UINavigationController(rootViewController: self.objDashboardViewController!)

        }
        else if ConfigManager.kCheckRootViewController == "myshop" {
            
            objSalonProfileViewController = SalonProfileViewController(nibName: "SalonProfileViewController", bundle: nil)
            navigationController = UINavigationController(rootViewController: self.objSalonProfileViewController!)

        }
        else if ConfigManager.kCheckRootViewController == "staff" {
            
            objEmployeeListViewController = EmployeeListViewController(nibName: "EmployeeListViewController", bundle: nil)
            navigationController = UINavigationController(rootViewController: self.objEmployeeListViewController!)

        }
        self.objSideMenuViewController = SideMenuViewController(nibName: "SideMenuViewController", bundle: nil)
        let slideMenuController = SlideMenuController(mainViewController: navigationController!, leftMenuViewController: self.objSideMenuViewController!)

        if ConfigManager.kCheckRootViewController == "dashboard" {

            slideMenuController.delegate = self.objDashboardViewController as? SlideMenuControllerDelegate

        }
        else if ConfigManager.kCheckRootViewController == "myshop"
        {
            slideMenuController.delegate = self.objSalonProfileViewController as? SlideMenuControllerDelegate

        }
        else
        {
            slideMenuController.delegate = self.objEmployeeListViewController as? SlideMenuControllerDelegate

        }

        self.window?.rootViewController = slideMenuController
        //window?.rootViewController = navigationController
        window?.makeKeyAndVisible()
    }*/
    func logoutFromApp() {
        
        ConfigManager.gUserId = ""
        ConfigManager.gFormNumber = ""
        ConfigManager.gEmail = ""
        ConfigManager.gSalonId = ""
        ConfigManager.gIsAdmin = ""
        ConfigManager.gEmployeePinNumber = ""
        ConfigManager.gCustomerPinNumber = ""
        ConfigManager.gEmployeeCode = ""
        ConfigManager.gEmployeeId = ""
        ConfigManager.gEmployeeName = ""
        ConfigManager.gEmployeeImage = ""

        UserDefaults.standard.set(nil, forKey: "USERID")
        UserDefaults.standard.set(nil, forKey: "EMAIL")
        UserDefaults.standard.set(nil, forKey: "SALONID")
        UserDefaults.standard.set(nil, forKey: "PASSWORD")
        UserDefaults.standard.set(nil, forKey: "EMP_PIN_NUM")
        UserDefaults.standard.set(nil, forKey: "CUST_PIN_NUM")
        UserDefaults.standard.set(nil, forKey: "EMP_CODE")
        UserDefaults.standard.set(nil, forKey: "EMP_ID")
        UserDefaults.standard.set(nil, forKey: "EMP_NAME")
        UserDefaults.standard.set(nil, forKey: "EMP_IMAGE")

        objLoginViewController = nil
        navigationController = nil
        objEmployeeCodeViewController = nil
        window?.rootViewController = nil
        
        if ConfigManager.DeviceType.IS_IPAD {
            
            objLoginViewController = LoginViewController(nibName: "LoginViewController", bundle: nil)
            
            navigationController = UINavigationController(rootViewController: objLoginViewController!)
            
        }
        else
        {
            objEmployeeCodeViewController = EmployeeCodeViewController(nibName: "EmployeeCodeViewController", bundle: nil)
            
            navigationController = UINavigationController(rootViewController: objEmployeeCodeViewController!)
        }
        
        window?.rootViewController = navigationController
        
       
        
    }
    func application(
        _ application: UIApplication,
        didReceiveRemoteNotification userInfo: [AnyHashable : Any],
        fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void) {
        
        let aps = userInfo["aps"] as! [String: AnyObject]
        
      /*  if aps["content-available"] as? Int == 1 {
            let podcastStore = PodcastStore.sharedStore
            podcastStore.refreshItems { didLoadNewItems in
                completionHandler(didLoadNewItems ? .newData : .noData)
            }
        } else  {
            _ = NewsItem.makeNewsItem(aps)
            completionHandler(.newData)
        }*/
    }
    
    func registerForPushNotifications() {
        UNUserNotificationCenter.current().requestAuthorization(options: [.alert, .sound, .badge]) {
            (granted, error) in
            print("Permission granted: \(granted)")
            
            guard granted else { return }
            
            let viewAction = UNNotificationAction(identifier: viewActionIdentifier,
                                                  title: "View",
                                                  options: [.foreground])
            
            let newsCategory = UNNotificationCategory(identifier: newsCategoryIdentifier,
                                                      actions: [viewAction],
                                                      intentIdentifiers: [],
                                                      options: [])
            
            UNUserNotificationCenter.current().setNotificationCategories([newsCategory])
            
            self.getNotificationSettings()
        }
    }
    
    func getNotificationSettings() {
        UNUserNotificationCenter.current().getNotificationSettings { (settings) in
            print("Notification settings: \(settings)")
            guard settings.authorizationStatus == .authorized else { return }
            DispatchQueue.main.async(execute: {
                UIApplication.shared.registerForRemoteNotifications()
            })
            
        }
    }
    
    func application(_ application: UIApplication,
                     didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data) {
        let tokenParts = deviceToken.map { data -> String in
            return String(format: "%02.2hhx", data)
        }
        
        let token = tokenParts.joined()
        print("Device Token: \(token)")
        
        let deviceToken:String! = token
        
        ConfigManager.gDeviceToken = deviceToken
        
//        let alert = UIAlertController(title: "Push", message: deviceToken, preferredStyle: .alert)
//        alert.addAction(UIAlertAction(title: "OK", style: .default, handler: nil))
//        self.window?.rootViewController?.present(alert, animated: true)
        
    }
    
    func application(_ application: UIApplication,
                     didFailToRegisterForRemoteNotificationsWithError error: Error) {
        print("Failed to register: \(error)")
    }
}

extension AppDelegate: UNUserNotificationCenterDelegate {
    
    func userNotificationCenter(_ center: UNUserNotificationCenter,
                                didReceive response: UNNotificationResponse,
                                withCompletionHandler completionHandler: @escaping () -> Void) {
        
        let userInfo = response.notification.request.content.userInfo
        let aps = userInfo["aps"] as! [String: AnyObject]
        
        
        
        /*if let newsItem = NewsItem.makeNewsItem(aps) {
            (window?.rootViewController as? UITabBarController)?.selectedIndex = 1
            
            if response.actionIdentifier == viewActionIdentifier,
                let url = URL(string: newsItem.link) {
                let safari = SFSafariViewController(url: url)
                window?.rootViewController?.present(safari, animated: true, completion: nil)
            }
        }*/
        
        completionHandler()
    }
    
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
    }




