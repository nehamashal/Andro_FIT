//
//  AppDelegate.swift
//  Fit Form Fix
//
//  Created by Neha on 21/06/23.
//

import UIKit
import IQKeyboardManagerSwift


var window: UIWindow?

@main
class AppDelegate: UIResponder, UIApplicationDelegate {


    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        IQKeyboardManager.shared.enable = true
        IQKeyboardManager.shared.shouldResignOnTouchOutside = true
                
        let isLoggedIn = UserDefaults.standard.string(forKey: "isLoggedIn") ?? "0"
        
        
        
        if isLoggedIn == "1"{
            //HomeNavVC
            let storyboard : UIStoryboard = StoryboardConstant.home
            let mainTabBarController = storyboard.instantiateViewController(identifier: "MainTabBarViewController")
                   window?.rootViewController = mainTabBarController
            (UIApplication.shared.delegate as? AppDelegate)?.changeRootViewController(mainTabBarController)
        }else{
            //WelcomeNavVC
            let storyboard : UIStoryboard = StoryboardConstant.main
            let loginNavController = storyboard.instantiateViewController(identifier: "WelcomeNavVC")
                    window?.rootViewController = loginNavController
        }
            
        return true
    }

    // MARK: UISceneSession Lifecycle

    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    func changeRootViewController(_ vc: UIViewController, animated: Bool = true) {
        guard let window = self.window else {
            return
        }

        window.rootViewController = vc

    }


}

