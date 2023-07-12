//
//  TabBarVC.swift
//  Andro Fit
//
//  Created by Neha on 07/07/23.
//

import Foundation
import UIKit

class MainTabBarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.delegate = self
    }
    
}

extension MainTabBarViewController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, didSelect viewController: UIViewController) {
        if viewController is HomeNavVC {
           print("Home")
        } else if viewController is HistoryNavVC {
            
            print("History")
        } else if viewController is SettingsNavVC {
            print("Settings")
        }else {
            print("Do Nothing...")
        }
        let navController = viewController as! UINavigationController
        navController.popToRootViewController(animated: true)
    }
}
